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

require 'test_helper'

class ReactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
