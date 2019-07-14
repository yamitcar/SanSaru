class MadeUniqueEventFullname < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :fullname, :string, unique: true
  end
end
