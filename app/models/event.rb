class Event < ApplicationRecord
  belongs_to :admin
  has_many :notifications, dependent: :destroy
    
  validates :title, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
    
  #管理者がイベントをつくった際の通知を作成するメソッド
  def create_notification_event!(evet_id)
   temp_ids = User.all.select(:id).distinct
   temp_ids.each do |temp_id|
   save_notification_event!(temp_id['id'])
   end
  end
  
  def save_notification_event!(visited_id)
   notification = Notification.new(
     event_id: id,
     visited_id: visited_id,
     action:  'event'
   )
   notification.save
  end

end
