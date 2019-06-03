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

class JwtBlacklist < ApplicationRecord
	include Devise::JWT::RevocationStrategies::Blacklist
	
	self.table_name = 'jwt_blacklists'
end
