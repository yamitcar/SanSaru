class AddEventToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :actual_event_id, :integer, index:true
    add_foreign_key :users, :events, column: :actual_event_id
  end
end
