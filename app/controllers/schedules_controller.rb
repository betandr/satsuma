class SchedulesController < ApplicationController
  def index
    @network = Network.find_by_web_key(params[:web_key])
    @broadcasts = @network.schedule.broadcasts_for_date(params[:period])
    
  end

end
