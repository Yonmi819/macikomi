class Tag < ApplicationRecord
    has_many :post_tags, dependent: :destroy
    has_many :posts, through: :post_tags
    #これによって、中間テーブルであるpost_tagモデルを介してのpostモデルとの関連付けを記述しています。
    
    
end
