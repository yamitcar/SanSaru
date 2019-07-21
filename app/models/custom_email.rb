class CustomEmail < ApplicationRecord
  belongs_to :event
  validates :template, presence: true
  validates :name, presence: true
  validates :copy_to, presence: true
end
