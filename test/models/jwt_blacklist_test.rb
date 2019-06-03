# == Schema Information
#
# Table name: jwt_blacklists
#
#  id         :integer          not null, primary key
#  jti        :string
#  exp        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class JwtBlacklistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
