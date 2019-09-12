class AdminForEvent < ApplicationRecord
  belongs_to :user, class_name: 'User', :foreign_key => 'user_id'
  belongs_to :event, class_name: 'Event', :foreign_key => 'event_id'
end
