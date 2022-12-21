class Admin::EventsController < ApplicationController
  
 def new
   @event = Event.new
 end
 
 def index
   Post.order(created_at: :desc).page(params[:page]).per(4)
   @events = Event.
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
   @event = Event.find(params[:id])
  if @event.update(event_params)
    redirect_to admin_events_path
  else
     render :edit
  end
 end
 
 def destroy
   @event = Event.find(params[:id])
   @event.destroy(event_params)
   redirect_to admin_events_path
 end
  
 private

 def event_params
   params.require(:event).permit(:title, :content, :start_time)
 end

end