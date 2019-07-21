class Page < ApplicationRecord
  has_paper_trail
  belongs_to :event
  validates :content, presence: true
  validates :path, presence: true, uniqueness: true
  validates_uniqueness_of :path
end