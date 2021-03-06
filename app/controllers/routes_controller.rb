class RoutesController < ApplicationController
  before_action :set_route, only: %i[show map destroy]

  def index
    @routes = Route.filter(params.slice(:load_name, :start_time, :date))
  end

  def new
    @route = Route.new
  end

  def create
    # route = Route.new(route_params)
    # if route.save!
    result = Route.process_stops(params)
    if result
      redirect_to routes_path
    else
      redirect_back :fallback_location
    end
  rescue StandardError => e
    puts e.message
    redirect_to new_route_path(), notice: "Error: #{e.message}"
  end

  def destroy
    redirect_to routes_path if @route.destroy
  rescue StandardError => e
    puts e.message
    redirect_to routes_path, notice: 'cant hold that request'
  end

  def map
    @coords =
      if @route
        [@route.map_stops]
      else
        Route.filter(params.slice(:load_name, :start_time, :date)).map(&:map_stops)
      end
  end

  private

  def route_params
    params.require(:route).permit(:load_name, :route, :date)
  end

  def set_route
    @route = Route.find_by id: params[:id] || params[:route_id] unless (params[:id] || params[:route_id]).blank?
  end
end