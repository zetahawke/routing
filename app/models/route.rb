require 'csv'

class Route < ApplicationRecord
  has_many :stops, dependent: :destroy

  validates :load_name, uniqueness: true

  include Filterable

  scope :load_name, -> (load_name) { where('load_name like ?', "%#{load_name}%") }
  scope :start_time, -> (start_time) { where('CAST ( start_time AS text ) like ?', "%#{start_time}%") }
  scope :date, -> (date) { where('CAST ( date AS text ) like ?', "%#{date}%") }

  def self.process_stops(params)
    raise StandardError.new('Cant verify params to build route stops') if params.blank?

    csv = params[:route][:stops]
    routes = []
    CSV.foreach(csv, headers: true) do |row|
      routes << {
        route: row['ruta'],
        arrived_time: row['hora_parada'],
        charge: row['carga'],
        latitude: row['latitude'],
        length: row['longitude']
      }
    end

    Route.build_routes(routes, params[:route][:load_name])
  end

  def self.build_routes(routes, load_name)
    routes = routes.group_by { |route| route[:route] }
    routes.each_with_index do |route_stops, index|
      route_number = route_stops.first
      stops = route_stops.last
      stops = stops.sort_by { |stop| stop[:arrived_time] }
      route = Route.create(
        load_name: "#{load_name}_#{index}",
        route: route_number,
        start_time: stops.first[:arrived_time].try(:to_time),
        end_time: stops.last[:arrived_time].try(:to_time)
      )
      # Route.build_stops(stops, route) now enqueued
      Delayed::Job.enqueue RouteUploads::ProcessFileUploadJob.new(route.id, stops)
    end
  end

  def build_stops(stops)
    stops.each do |stop|
      Stop.create(
        route_id: self.id,
        arrived_time: stop[:arrived_time],
        charge: stop[:charge],
        latitude: stop[:latitude],
        length: stop[:length]
      )
    end
  end

  def map_stops
    stops.map { |stop| { lat: stop.latitude.to_f.round(2), lng: stop.length.to_f.round(2) } }
  end
end
