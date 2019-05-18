class Template < ApplicationRecord
    #validations
    validates :description, presence: true
    validates_associated :picture
    validates_presence_of :picture
    #1-1
    has_one :picture, as: :imageable, dependent: :destroy
end
