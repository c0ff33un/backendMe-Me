class PostMeme < ApplicationRecord

  #1-1
  belongs_to :post
  belongs_to :meme

  
end
