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

require 'test_helper'

class PostMemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
