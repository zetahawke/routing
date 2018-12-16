class MapChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'map_channel'
  end

  def unsubscribed; end

  def refresh_info
    # working on
  end
end
