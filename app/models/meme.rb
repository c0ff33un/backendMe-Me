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
  validates :image, presence: true, attached: true, file_size: { less_than: 3.megabytes },
										file_content_type: { allow: ['image/jpeg', 'image/png'] }

	#Scopes
	scope :from_user, -> (user) {
		where(:user_id => user) if user.present?
	} 

  scope :not_hidden, -> {
    where(hidden: false)
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



  # Recalculate meme score based on Wilson Score
  # http://www.akitaonrails.com/2016/10/31/ruby-on-rails-implementation-of-a-proper-ranking-popularity-system
  
  def re_score!
    _p = 2*swipe_up + swipe_right
    _n = 2*swipe_down + swipe_left
    if _p + _n == 0 
      s = 0
    else
      s = (((_p + 1.9208) / (_p + _n) -1.96 * Math.sqrt((_p * _n) / (_p + _n) + 0.9604) / (_p + _n)) / (1 + 3.8416 / (_p + _n)))*1000000
      s.round
    end
    self.score = s
    self.save
  end

  #Queries
  
  #Filter by date
  def self.filter( upload_date = Time.use_zone(Time.zone.name) { 1.week.ago }) 
    self.not_hidden.where(created_at:(upload_date..Time.zone.now))
  end

  def self.best
    self.filter( upload_date = Time.use_zone(Time.zone.name) { 1.month.ago }).order_by_rand_weighted(:score)
  end

  def self.hot
    self.filter.order_by_rand_weighted(:score)
  end

  def self.newest
    self.not_hidden.order( 'created_at DESC')
  end

end
