class Post < ApplicationRecord
  #validations
  validates :body, length: {maximum: 125}
  validates_associated :post_memes, :comments

  #1-1
  belongs_to :user
  #1-n
  has_many :comments, as: :commentable
  #n-n
  has_many :post_memes
  has_many :memes, through: :post_memes
end
