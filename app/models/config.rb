class Config < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
  validates :value, presence: true
end
