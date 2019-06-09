# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  commentable_type :string
#  commentable_id   :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
  validates :body, presence: true, length: {maximum: 125}
  #1-1
  belongs_to :user, counter_cache: true
  belongs_to :commentable, polymorphic: true
end
