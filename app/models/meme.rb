class Meme < ApplicationRecord
  #1-1
  belongs_to :user
  #n-n
  has_many :post_memes
  has_many :posts, through: :post_memes
  
  has_many :reactions
  has_many :users, through: :reactions
end
