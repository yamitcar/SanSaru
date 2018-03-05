class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.references :invited_one, optional: true
      t.references :invited_two, optional: true
      t.datetime :one_on
      t.datetime :two_on
      t.timestamps
    end
  end
end
