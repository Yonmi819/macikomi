class User < ApplicationRecord 
  has_one_attached :image
  has_many :posts , dependent: :destroy
  has_many :post_comments , dependent: :destroy
  has_many :checks, dependent: :destroy
  #通知機能実装のため
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com',last_name: '鈴木',first_name: '太郎',last_name_kana: 'スズキ',first_name_kana: 'タロウ') do |user|
      user.password = SecureRandom.urlsafe_base64
    
    end
  end
  
  def active_for_authentication?
    super && (delete_flag == false)
  end
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
  
  
  end
