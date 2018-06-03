class AddContactInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :phonenumber, :string, null: false, default: ''
    add_column :profiles, :telegram, :string
  end
end
