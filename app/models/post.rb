class Post < ApplicationRecord
   has_one_attached :image
   belongs_to :user
   has_many :post_comments, dependent: :destroy
   has_many :notifications, dependent: :destroy
   has_many :checks, dependent: :destroy
   
   
   validates :title, presence: true
   validates :body,  presence: true, length: { maximum: 200 }
   
   
   
   def checked_by?(user)
       checks.exists?(user_id: user.id)
   end
    
   
   #投稿した時の通知を作成するメソッド↓
   def create_notification_post!(current_user)
  # 全ユーザーを取得
  temp_ids = User.all.select(:id).distinct
  temp_ids.each do |temp_id|
    save_notification_post!(current_user, temp_id['id'])
    end
   end

   def save_notification_post!(current_user, visited_id)
  notification = current_user.active_notifications.new(
      visited_id: visited_id,
      post_id: id,
      action: 'post'
    )
    notification.save if notification.valid?
  end



  
 
 

end 