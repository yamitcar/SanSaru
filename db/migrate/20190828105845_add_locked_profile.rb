class AddLockedProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :locked, :boolean, default: false
  end
end
