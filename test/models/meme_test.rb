# == Schema Information
#
# Table name: memes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  swipe_up    :integer          default(0)
#  swipe_down  :integer          default(0)
#  swipe_left  :integer          default(0)
#  swipe_right :integer          default(0)
#

require 'test_helper'

class MemeTest < ActiveSupport::TestCase
  def setup
    user = users(:test_user)
    @meme = user.memes.new
    @fixture_path = File.join(Rails.root, 'test','fixtures','files','image_50kb.jpg')
    @fixture_path_gif = File.join(Rails.root, 'test','fixtures','files','image_wrong_type.gif')
  end

  test "create meme no image" do
    assert_not @meme.image.attached?
  end

  test "create meme with image" do 
    fixture_file = File.open(@fixture_path)
    @meme.image.attach({io: fixture_file, filename: "meme.jpg"})
    assert @meme.valid?
  end

  test "create meme with wrong image file size" do 
    fixture_file = File.open(@fixture_path)
    fixture_file.stubs(:size).returns(21.megabytes)
    @meme.image.attach({io: fixture_file, filename: "meme.jpg"})
    assert_not @meme.valid?
  end

  test "create meme with wrong image mimetype" do 
    fixture_file = File.open(@fixture_path_gif)
    @meme.image.attach({io: fixture_file, filename: "meme.gif"})
    assert_not @meme.valid?
  end
end
