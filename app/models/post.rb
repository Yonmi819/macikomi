class Post < ApplicationRecord
   belongs_to :user
   has_many :post_comments, dependent: :destroy
   
   validates :title, presence: true
   validates :body,  presence: true, length: { maximum: 200 }
   
   has_one_attached :image
  
  
 
 

end 