class User::NotificationsController < ApplicationController
 
 def index #受け取った通知を表示し確認済みにする
   @notifications = current_user.passive_notifications.page(params[:page]).per(10)
   @notifications.where(checked: false).each do |notification|
    notification.update(checked: true)
  end
 end
  
  #通知を全削除するメソッド
 def destroy_all
     @notifications = current_user.passive_notifications.destroy_all
     redirect_to user_notifications_path
     
 end
end
