class PostMeme < ApplicationRecord
  #1-1
  belongs_to :post
  belongs_to :meme
  #1-n
  has_many :comments, as: :commentable
end
