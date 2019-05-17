class Reaction < ApplicationRecord
  validates :reaction_type, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 4}, presence: true
  
  #1-1
  belongs_to :user
  belongs_to :meme
end
