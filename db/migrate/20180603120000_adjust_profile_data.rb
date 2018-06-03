class AdjustProfileData < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :country, :string, null: false, default: ''
    add_column :profiles, :state, :string, null: false, default: ''
    add_column :profiles, :city, :string,null: false, default: ''
    remove_column :profiles, :residence
  end
end
