class Event < ApplicationRecord
    belongs_to :admin
    has_many :notifications, dependent: :destroy
    
     #管理者がイベントをつくった時の通知を作成するメソッド↓
   def create_notification_event!(current_admin)
     # 全ユーザーを取得
    temp_ids = User.all.select(:id).distinct
    temp_ids.each do |temp_id|
    save_notification_event!(current_user, temp_id['id'])
    end
   
   end

   def save_notification_event!(current_user, visited_id)
    notification = current_admin.notifications.new(
    visited_id: visited_id,
    event_id: id,
    action: 'event'
   )
   
   end
    


end
