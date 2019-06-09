# == Schema Information
#
# Table name: reactions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  meme_id       :integer
#  reaction_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reaction < ApplicationRecord
  validates :reaction_type, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 3}, presence: true

  validates_uniqueness_of :user_id, :scope => [:meme_id] #composite key
  #Callbacks
  after_create :update_counter
  before_update :decrease_counter
  after_update :update_counter
  before_destroy :decrease_counter
  #1-1
  belongs_to :user
  belongs_to :meme
  
  private
    #The idea is that each meme keeps counts of the reactions given
    #and also that each user knows how many reactions of each type has made.
    @@type = ['swipe_up', 'swipe_down', 'swipe_left', 'swipe_right']
    def update_counter
      reaction = @@type[self.reaction_type]
      self.meme.update({reaction.to_sym => self.meme[reaction.to_sym]+1})
      self.user.update({reaction.to_sym => self.user[reaction.to_sym]+1})
    end
    def decrease_counter
      reaction = @@type[self.reaction_type_was]
      self.meme.update({reaction.to_sym => self.meme[reaction.to_sym]-1})
      self.user.update({reaction.to_sym => self.user[reaction.to_sym]-1})
    end
  end
