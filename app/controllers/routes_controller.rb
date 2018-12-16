class RoutesController < ApplicationController
  before_action :set_route, only: %i[show map]

  def new
    @route = Route.new
  end

  def create
    route = Route.new(route_params)
    if route.save!
      redirect_to route_map_path(route)
    else
      redirect_back fallback_location
    end
  end

  def map; end

  private

  def route_params
    params.require(:route).permit(:load_name, :route, :date, :start_time, :end_time,)
  end

  def set_route
    @route = Route.find_by id: params[:id] || params[:route_id] unless (params[:id] || params[:route_id]).blank?
  end
end