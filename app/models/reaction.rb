class Reaction < ApplicationRecord
  validates :reaction_type, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 4}, presence: true

  #Callbacks
  after_create :increase_counter

  #1-1
  belongs_to :user
  belongs_to :meme

  private
    def increase_counter
      reaction = self.reaction_type
      mem = self.meme
      if reaction == 0    #up
        mem.update({swipe_up: mem.swipe_up+1})
      elsif reaction == 1 #down
        mem.update({swipe_down: mem.swipe_down+1})
      elsif reaction == 2 #left
        mem.update({swipe_left: mem.swipe_left+1})
      else                #right
        mem.update({swipe_right: mem.swipe_right+1})
      end
    end

    def update_counter
    end
end
