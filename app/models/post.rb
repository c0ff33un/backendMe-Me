# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  #Scopes
	scope :from_user, -> (user) {
		where(:user_id => user) if user.present?
	} 

  #1-1
  belongs_to :user, counter_cache: true
  #1-n
  has_many :comments, as: :commentable, dependent: :destroy
  #n-n
  has_many :post_memes, dependent: :destroy
  has_many :memes, through: :post_memes, dependent: :destroy

  #validations
  validates :body, length: {maximum: 125}
  validates_associated :post_memes, :comments
  accepts_nested_attributes_for :post_memes, reject_if:[:new_record?, :reject_post_memes] #https://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
  validates :post_memes, :length=>{:minimum=>1, :maximum=>10}
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

  private
  def reject_post_memes(attributes)
    attributes['body'].blank?
  end
end
