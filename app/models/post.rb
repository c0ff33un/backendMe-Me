class Post < ApplicationRecord
  #validations
  validates :body, length: {maximum: 125}
  validates_associated :post_memes, :comments

  #Scopes
	scope :from_user, -> (user) {
		where(:user_id => user) if user.present?
	} 

  #1-1
  belongs_to :user
  #1-n
  has_many :comments, as: :commentable, dependent: :destroy
  #n-n
  has_many :post_memes, dependent: :destroy
  has_many :memes, through: :post_memes, dependent: :destroy

  #Queries
  def self.filter( upload_date = Time.use_zone(Time.zone.name) { 1.week.ago }, page = 1 ) 
    self.where(created_at:(upload_date..Time.zone.now))
  end

  def self.best
    self.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')
  end

  def self.hot
    self.left_joins(:comments).group(:id).
    order("AVG( strftime('%Y%m%d', comments.created_at )) DESC")
  end

  def self.newest
    self.order( 'created_at DESC')
  end

end
