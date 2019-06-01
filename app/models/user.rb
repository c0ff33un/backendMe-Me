class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
	       :recoverable, :rememberable, :validatable,
	       :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
	#validations
	validates :handle, length: {in: 5..20}, presence: true, uniqueness: true, allow_blank: false
	validate :birthday_in_range
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

	def generate_jwt
		JWT.encode({id: id,
								exp: 60.days.from_now.to_i},
							Rails.application.credentials.secret_key_base)
	end
	private 

		def birthday_in_range
			birthday.inspect
			if birthday > Time.now
				errors.add(:birthday, "the future is now, old man")
			elsif birthday < Time.now - 125.years
				errors.add(:birthday, "too old for our memes")
			elsif birthday > Time.now - 15.years
				errors.add(:birthday, "too young for our memes")
			end
		end

end
