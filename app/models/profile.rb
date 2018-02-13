class Profile < ApplicationRecord
    has_one :size
    has_one :gender
    has_one :agile
    has_one :agileRelation
    validates :residence, presence: true
    validates :expectancy, presence: true
    validates :agile_description, presence: true
    validates :bio, presence: true
end
