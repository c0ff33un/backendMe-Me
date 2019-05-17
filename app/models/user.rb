class User < ApplicationRecord
	validates :handle, lenght:{in: 5..20}, presence: true, uniqueness: true
	validates :pass, :password_salt, presence: true
	valitates :age, numericality:{only_integer: true, greater_than: 15, less_than: 99}, presence: true

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
