class Profile < ApplicationRecord
    has_one :size
    has_one :gender
    has_one :agile
    has_one :agileRelation
    validates :name, presence: true
    validates :lastname, presence: true
    validates :email, uniqueness: true
    validates_email_format_of :email, :message => 'verifica tu email'
    validates :residence, presence: true
    validates :expectancy, presence: true
    validates :agile_description, presence: true
    validates :bio, presence: true
      
end
