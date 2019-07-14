class ProfilesPerEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :user_id, :integer, index:true
    add_foreign_key :profiles, :users, column: :user_id
    add_column :profiles, :event_id, :integer, index:true
    add_foreign_key :profiles, :events, column: :event_id
    remove_column :users, :profile_id
  end
end
