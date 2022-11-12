class Admin::EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.admin_id = current_admin.id
    @event.save
    @event.create_notification_event!(current_admin)
    redirect_to new_admin_event_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :start_time)
  end

end