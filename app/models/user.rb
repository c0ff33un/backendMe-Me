# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  handle                 :string
#  birthday               :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
	       :recoverable, :rememberable, :validatable,
	       :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
	#validations
	validates :handle, length: {in: 5..20}, presence: true, uniqueness: true, allow_blank: false
	validates_associated :memes, :posts, :comments, :reactions, :avatar
	validate :birthday_in_range, if: :birthday
	validates :birthday, presence: true, allow_blank: false
	validates :avatar ,file_size: { less_than: 2.megabytes },
											file_content_type: { allow: ['image/jpeg', 'image/png'] }, if: -> {avatar.attached?}


	#Scopes'
	scope :confirmed, -> {
		where.not(:confirmed_at => nil)
	} 
	
	#1-1
	#active storage
	has_one_attached :avatar, dependent: :purge_later
	#1-n
	has_many :comments, dependent: :destroy
	has_many :memes, dependent: :destroy
	has_many :posts, dependent: :destroy
	#n-n
	has_many :reactions, dependent: :destroy
	#has_many :memes, through: :reactions
	
	#Oauth
	def self.find_for_oauth(auth)
		user = User.where(uid: auth["id"], provider: auth["provider"]).first
		unless user
			user = User.new(
				uid: auth["id"],
				provider: auth["provider"],
				email: auth["email"],
				handle: 'temp'+String(rand(1000000)),
				birthday: auth["birthday"],
				password: Devise.friendly_token[0,20]
			)
			user.skip_confirmation!
			user.save
		end
		user
	end
	
	#Queries
	def best_memes
		Meme.from_user(self.id).best
	end

	def best_posts
		Post.from_user(self.id).best
	end

	def stats
		stats = { 
			comments_count: self.comments_count,
			memes_count: self.memes_count,
			posts_count: self.posts_count,
			reaction_count: {
				swipe_up: self.swipe_up,
				swipe_down: self.swipe_down,
				swipe_left: self.swipe_left,
				swipe_right: self.swipe_right
			}
		}
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
