class Meme < ApplicationRecord
  #validations
  validates_associated :picture, :reactions, :post_memes
  validates_presence_of :picture
  #1-1
  belongs_to :user
  has_one :picture, as: :imageable, dependent: :destroy
  #n-n
  has_many :post_memes, dependent: :destroy
  has_many :posts, through: :post_memes, dependent: :destroy
  
  has_many :reactions, dependent: :destroy
  #has_many :users, through: :reactions
end
