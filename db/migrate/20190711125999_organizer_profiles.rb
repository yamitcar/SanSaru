class OrganizerProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :organizer, :boolean, null: false, default: false
    remove_column :users, :organizer
  end
end
