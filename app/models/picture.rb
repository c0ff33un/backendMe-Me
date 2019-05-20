class Picture < ApplicationRecord
    #validations
    validates :image, presence: true
    #1-1
    belongs_to :imageable, polymorphic: true
end
