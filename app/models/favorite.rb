class Favorite < ApplicationRecord
  belongs_to :user

  def self.delete_favorite(user_id,favorite_user_id,event_id)
    create!(user_id: user_id,
            favorite_user_id:favorite_user_id,
            event_id: event_id)
  end
end
