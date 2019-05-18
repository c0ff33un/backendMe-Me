class Post < ApplicationRecord
  #validations
  validates :body, length: {maximum: 125}
  validates_associated :post_memes, :comments

  #1-1
  belongs_to :user
  #1-n
  has_many :comments, as: :commentable, dependent: :destroy
  #n-n
  has_many :post_memes, dependent: :destroy
  has_many :memes, through: :post_memes, dependent: :destroy
end
