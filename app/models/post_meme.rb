class PostMeme < ApplicationRecord
  #validations
  validates_associated :comments

  #1-1
  belongs_to :post
  belongs_to :meme
  #1-n
  has_many :comments, as: :commentable, dependent: :destroy
end
