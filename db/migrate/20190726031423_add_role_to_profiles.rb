class AddRoleToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :role, :string, null: false
  end
end
