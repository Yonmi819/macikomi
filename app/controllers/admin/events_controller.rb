class Admin::EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to new_admin_event_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :start_time)
  end

end