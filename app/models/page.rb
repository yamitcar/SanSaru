class Page < ApplicationRecord
  belongs_to :event
  validates :content, presence: true
  validates :path, presence: true, uniqueness: true
end