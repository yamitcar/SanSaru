class Invitation < ApplicationRecord
  belongs_to :invited_one, :class_name => "User", optional: true
  belongs_to :invited_two, :class_name => "User", optional: true
  belongs_to :user, :class_name => "User"
end
