class EventsController < ApplicationController
  def index
    @start = params[:start]
    @end = params[:end]
    
    @network = Network.find_by_web_key(params[:web_key])
    
    @events = @network.network_events_for_start_timestamp_and_end_timestamp(@start, @end)
    @events.sort! { |a,b| a[:start] <=> b[:start] }
  end

  def show
    @event = Event.find_by_realtime_id(params[:realtime_id])

    if @event.nil?
      @event = Event.load_by_realtime_id(params[:realtime_id])
    end
    
    @rot_url = Rot.new.rot_for_event(@event)
  end

end
