class Post < ApplicationRecord
   has_one_attached :image
   belongs_to :user
   has_many :post_comments, dependent: :destroy
   has_many :notifications, dependent: :destroy
   has_many :checks, dependent: :destroy
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
   
   
   validates :title, presence: true
   validates :body,  presence: true, length: { maximum: 200 }
   
   
   
   def checked_by?(user)
       checks.exists?(user_id: user.id)
   end
   
    
   
   #投稿した時の通知を作成するメソッド↓
   def create_notification_post!(current_user)#←引数:新しくつくられる変数
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
  
  #コメントした時の通知を作成するメソッド↓
  def create_notification_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    #temp_idsには自分以外で、タスクにコメントしたuserを見つけ出す。その際、distinctを使用することで、userが重複しないようにしている。
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
   end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)#誰がコメントしたか
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    #current_userに関連づいたactive_notifications(自分が送る側の通知)を作成
    notification = current_user.active_notifications.new(
      post_id: id, #どの投稿に
      post_comment_id: post_comment_id, #コメントしたID
      visited_id: visited_id, #誰に送るのか（通知先）
      action: 'comment'#通知の種類
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end



  
 
 

end 