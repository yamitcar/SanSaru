class Gender < ApplicationRecord
  has_paper_trail
  validates :name, presence: true
end
