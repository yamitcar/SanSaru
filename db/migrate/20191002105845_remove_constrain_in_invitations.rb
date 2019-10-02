class RemoveConstrainInInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_index :invitations, name: "index_invitations_on_user_id"
    add_index :invitations, :user_id
  end
end
