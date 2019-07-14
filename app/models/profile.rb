class Profile < ApplicationRecord
  has_paper_trail
  belongs_to :size
  belongs_to :gender
  belongs_to :agile
  belongs_to :agileRelation

  belongs_to :user
  belongs_to :event

  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :expectancy, presence: true
  validates :agile_description, presence: true
  validates :bio, presence: true
  validates :phonenumber, presence: true
end
