class Template < ApplicationRecord
    #1-1
    has_one :picture, as: :imageable
end
