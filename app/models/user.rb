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
	validate :birthday_in_range
	validates_associated :memes, :posts, :comments, :reactions, :avatar

	#Scopes
	scope :confirmed, -> {
		where.not(:confirmed_at => nil)
	} 
	
	#1-1
	#active storage
	has_one_attached :avatar #apparently dependence comes within it https://api.rubyonrails.org/classes/ActiveStorage/Attached/Macros.html
	#1-n
	has_many :comments, dependent: :destroy
	has_many :memes, dependent: :destroy
	has_many :posts, dependent: :destroy
	#n-n
	has_many :reactions, dependent: :destroy
	#has_many :memes, through: :reactions
	
	#Queries
	def best_memes
		Meme.from_user(self.id).best
	end

	def best_posts
		Post.from_user(self.id).best
	end

	def stats
		stats = { 
			:comments => self.comments.length,
			:own_memes => self.memes.length,
			:own_posts => self.posts.length,
			:reactions => self.reactions.length
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
