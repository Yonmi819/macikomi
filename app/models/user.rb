class User < ApplicationRecord 
  has_one_attached :image
  has_many :posts , dependent: :destroy
  has_many :post_comments , dependent: :destroy
  has_many :checks, dependent: :destroy
  
  #通知機能実装のため
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  #ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com',last_name: "ゲスト",first_name: '怜奈',last_name_kana: 'ゲスト',first_name_kana: 'レナ') do |user|
     user.password = SecureRandom.urlsafe_base64
     user.last_name = "ゲスト"
    end
  end
  
  #ログインできるユーザーか確認
  def active_for_authentication?
    super && (delete_flag == false)
  end
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
   
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
