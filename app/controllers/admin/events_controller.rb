class Admin::EventsController < ApplicationController
  
 def new
   @event = Event.new
 end
  
 def create
   @event = Event.new(event_params)
   @event.admin_id = current_admin.id
  if @event.save
   @event.create_notification_event!(@event.id)
   flash[:notice] = 'イベントを作成しました!'
    redirect_to new_admin_event_path
  else
    flash.now[:notice] = '必要事項が入力されていないです'
    render :new
  end
 end
 
 def update
 end
 
 def destroy
 end
  
 private

 def event_params
   params.require(:event).permit(:title, :content, :start_time)
 end

end