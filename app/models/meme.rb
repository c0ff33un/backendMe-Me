class Meme < ApplicationRecord
  #validations
  validates_associated :picture, :reactions, :post_memes
  validates_presence_of :picture

  #1-1
  belongs_to :user
  has_one :picture, as: :imageable, dependent: :destroy
  #n-n
  has_many :post_memes, dependent: :destroy
  has_many :posts, through: :post_memes, dependent: :destroy
  
  has_many :reactions, dependent: :destroy
  #has_many :users, through: :reactions

  def self.filter( upload_date = Time.use_zone(Time.zone.name) { 1.week.ago } ) 
    self.where('created_at >= ?', upload_date ).pluck(:id)
  end

  def self.best
    self.left_joins(:reactions).group(:id).
    order('COUNT(reactions.id) DESC').
    pluck(:id)
  end

  def self.hot
  
    self.left_joins(:reactions).group(:id).
    order("AVG( strftime('%Y%m%d', reactions.created_at )) DESC").
    pluck(:id)

  end

  def self.newest
    self.order( 'created_at DESC').pluck(:id)
  end

end
