class User < ApplicationRecord
	#validations
	validates :handle, length: {in: 5..20}, presence: true, uniqueness: true
	validates :pass, :password_salt, presence: true
	validates :age, numericality: {
		only_integer: true,
		greater_than_or_equal_to: 15,
		less_than_or_equal_to: 100}, presence: true

	validates_associated :memes, :posts, :comments, :reactions, :picture

	#1-1
	has_one :picture, as: :imageable, dependent: :destroy
	#1-n
	has_many :comments, dependent: :destroy
	has_many :memes, dependent: :destroy
	has_many :posts, dependent: :destroy
	#n-n
	has_many :reactions, dependent: :destroy
	#has_many :memes, through: :reactions
end
