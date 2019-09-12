class AdminForEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_for_events do |t|
      t.timestamps
    end
    add_column :admin_for_events, :user_id, :integer, index:true
    add_foreign_key :admin_for_events, :users, column: :user_id
    add_column :admin_for_events, :event_id, :integer, index:true
    add_foreign_key :admin_for_events, :events, column: :event_id
  end
end
