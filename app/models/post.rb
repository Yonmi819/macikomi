class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :checks, dependent: :destroy
    
   
   validates :title, presence: true
   validates :body,  presence: true, length: { maximum: 200 }
   
   
   #すでに投稿をチェックしたユーザーが存在しているかの確認をするメソッド
  def checked_by?(user)
   checks.exists?(user_id: user.id)
  end
  
  #投稿したときに通知を作成するメソッド
  def create_notification_post!(current_user)
   temp_ids = User.all.select(:id).distinct #全ユーザーを取得
   temp_ids.each do |temp_id|
   save_notification_post!(current_user, temp_id['id'])
   end
  end
  
  def save_notification_post!(current_user, visited_id)
   notification = current_user.active_notifications.new(
     post_id: id,
     visited_id: visited_id,
     action: 'post'
   )  
   notification.save  
  end 
    
  #コメントした時の通知を作成するメソッド↓
  def create_notification_comment!(current_user, post_comment_id)
   temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
   temp_ids.each do |temp_id|
   save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
   end
  end
  
  def save_notification_comment!(current_user, post_comment_id, visited_id)
   notification = current_user.active_notifications.new(
     post_id: id, 
     post_comment_id: post_comment_id,
     visited_id: visited_id,
     action: 'comment'
   )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save
  end
end 



  