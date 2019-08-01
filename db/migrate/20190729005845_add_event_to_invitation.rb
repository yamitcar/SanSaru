class AddEventToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :event_id, :integer, index:true
    add_foreign_key :invitations, :events, column: :event_id
  end
end
