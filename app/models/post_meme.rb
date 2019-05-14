class PostMeme < ApplicationRecord
  belongs_to :post
  belongs_to :meme
end
