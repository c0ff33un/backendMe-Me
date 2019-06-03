# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  image          :binary
#  imageable_type :string
#  imageable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Picture < ApplicationRecord
    #validations
    validates :image, presence: true
    #1-1
    belongs_to :imageable, polymorphic: true
end
