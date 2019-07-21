class CustomEmail < ApplicationRecord
  has_paper_trail
  belongs_to :event
  validates :template, presence: true
  validates :name, presence: true
  validates :copy_to, presence: true
end
