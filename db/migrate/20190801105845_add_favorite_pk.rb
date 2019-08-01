class AddFavoritePk < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :id, :primary_key
  end
end
