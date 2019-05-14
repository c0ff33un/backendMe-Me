class Comment < ApplicationRecord
  #1-1
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
