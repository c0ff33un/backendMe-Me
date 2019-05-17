class Comment < ApplicationRecord
  validates :body, presence: true, length: {maximum: 125}
  #1-1
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
