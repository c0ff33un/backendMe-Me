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

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
	       :recoverable, :rememberable, :validatable, :trackable,
	       :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist,
	       :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
	# validations
	validates :handle, length: {in: 5..20}, presence: true, uniqueness: true, allow_blank: false
	validates_associated :memes, :posts, :comments, :reactions, :avatar
	validate :birthday_in_range
	validates :avatar ,file_size: { less_than: 2.megabytes },
											file_content_type: { allow: ['image/jpeg', 'image/png'] }, if: -> {avatar.attached?}

	# Scopes'
	scope :confirmed, -> {
		where.not(:confirmed_at => nil)
	} 
	
	# 1-1
	# Active storage
	has_one_attached :avatar, dependent: :purge_later
	# 1-n
	has_many :comments, dependent: :destroy
	has_many :memes, dependent: :destroy
	has_many :posts, dependent: :destroy
	# n-n
	has_many :reactions, dependent: :destroy
	# has_many :memes, through: :reactions
	has_many :identities, dependent: :destroy
	# Queries
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

	def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
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
