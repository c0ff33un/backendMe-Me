class Reaction < ApplicationRecord
  #1-1
  belongs_to :user
  belongs_to :meme
end
