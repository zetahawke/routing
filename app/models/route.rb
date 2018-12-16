class Route < ApplicationRecord
  has_many :stops, dependent: :destroy

  validates :load_name, uniqueness: true

  def self.proccess_stops(params)
    raise StandardError.new('Cant verify params to build route stops') if params.blank?

    csv = params[:route][:stops]
    routes = []
    CSV.foreach(csv, headers: true) do |row|
      routes << {
        route: row['ruta'],
        route_id: self.id,
        arrived_time: row['hora_parada'],
        charge: row['carga'],
        latitude: row['latitude'],
        length: row['longitude']
      }
    end
  end

  def self.build_routes(routes)
    routes = routes.group_by { |route| route[:route] }
    routes.each_with_index do |route_number, stops, index|
      binding.pry
      stops = stops.sort_by { |stop| stop[:arrived_time] }
      route = Route.create(
        load_name: "#{params[:route][:load_name]}_#{index}",
        route: route_number,
        start_time: stops.first[:arrived_time],
        start_time: stops.last[:arrived_time],
        date: stops.last[:arrived_time].try(:to_date)
      )
      Route.build_stops(stops, route)
    end
  end

  def self.build_stops(stops, route)
    stops.each do |stop|
      Stop.create(
        route_id: route.id,
        arrived_time: stop[:arrived_time],
        charge: stop[:charge],
        latitude: stop[:latitude],
        length: stop[:length]
      )
    end
  end
end
