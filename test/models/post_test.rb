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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # def setup
  #   @user = users(:test_user)
  #   fixture_path = File.join(Rails.root, 'test','fixtures','files','image_50kb.jpg')
  #   fixture_file = File.open(fixture_path)
  # end
  # test "create simple post" do
  #   meme = @user.memes.new
  #   meme.stubs(:image).returns

  # end
end
