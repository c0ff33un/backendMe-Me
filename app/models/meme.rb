class Meme < ApplicationRecord
  #validations
  validates_associated :picture, :reactions, :post_memes, :comments
  validates_presence_of :picture

	#Scopes
	scope :from_user, -> (user) {
		where(:user_id => user) if user.present?
	} 

  #1-1
  belongs_to :user
  has_one :picture, as: :imageable, dependent: :destroy
  #n-n
  has_many :post_memes, dependent: :destroy
  has_many :posts, through: :post_memes, dependent: :destroy
  
  #1-n
  has_many :reactions, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  #has_many :users, through: :reactions

  #Queries
  def self.filter( upload_date = Time.use_zone(Time.zone.name) { 1.week.ago }, page = 1 ) 
    self.where(created_at:(upload_date..Time.zone.now))
  end

  def self.best
    self.left_joins(:reactions).group(:id).order('COUNT(reactions.id) DESC')
  end

  def self.hot
    self.left_joins(:reactions).group(:id).
    order("AVG( strftime('%Y%m%d', reactions.created_at )) DESC")
  end

  def self.newest
    self.order( 'created_at DESC')
  end

end
