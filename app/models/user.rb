class User < ApplicationRecord
	#1-1
	has_one :picture, as: :imageable
	#1-n
	has_many :comments
	has_many :memes
	has_many :posts
	#n-n
	has_many :reactions
	#has_many :memes, through: :reactions
end
