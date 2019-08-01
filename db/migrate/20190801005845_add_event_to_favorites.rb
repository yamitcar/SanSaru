class AddEventToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :event_id, :integer, index:true
    add_foreign_key :favorites, :events, column: :event_id
  end
end
