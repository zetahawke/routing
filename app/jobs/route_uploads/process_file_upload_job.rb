require 'csv'

module RouteUploads
  class ProcessFileUploadJob < Struct.new(:route_id, :stops)
    def enqueue(job)
      job.delayed_reference_id   = route_id
      job.delayed_reference_type = 'Route'
      job.save!
    end

    def success(job)
      update_status('success')
    end

    def error(job, exception)
      update_status('temp_error')
      # Send email notification / alert / alarm
    end

    def failure(job)
      update_status('failure')
      # Send email notification / alert / alarm / SMS / call ... whatever
    end

    def perform
      route = Route.find route_id
      route.build_stops(stops)
    end

    private

    def update_status(status)
      route = Route.find route_id
      route.status = status
      route.save!
    end

    def check_and_update_status
      route = Route.find route_id
      raise StandardError.new("Route: #{route.id} is not on status 'new' (status: #{route.status}") unless route.status == 'new'
      route.status = 'processing'
      route.save!
    end
  end
end
