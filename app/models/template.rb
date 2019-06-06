# == Schema Information
#
# Table name: templates
#
#  id          :integer          not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Template < ApplicationRecord
    #validations
    validates :description, presence: true
    validates_associated :image
    validates_presence_of :image
    #1-1
    has_one_attached :image #active_storage
end
