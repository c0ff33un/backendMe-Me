# == Schema Information
#
# Table name: post_memes
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  meme_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostMeme < ApplicationRecord
  #1-1
  belongs_to :post
  belongs_to :meme
  #validations
  validates_uniqueness_of :meme_id, :scope => [:post_id] #composite key, avoid same meme on post
  
end
