# == Schema Information
#
# Table name: memes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  swipe_up    :integer          default(0)
#  swipe_down  :integer          default(0)
#  swipe_left  :integer          default(0)
#  swipe_right :integer          default(0)
#

class Meme < ApplicationRecord
  #validations
  validates_associated :image, :reactions, :post_memes, :comments
  validates_presence_of :image
  validates :image , attached: true, file_size: { less_than: 3.megabytes },
										file_content_type: { allow: ['image/jpeg', 'image/png'] }

	#Scopes
	scope :from_user, -> (user) {
		where(:user_id => user) if user.present?
	} 

  #1-1
  belongs_to :user, counter_cache: true
  #active storage
  has_one_attached :image, dependent: :purge_later
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
