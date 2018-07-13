class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites, id: false do |t|
      t.integer :user_id
      t.integer :favorite_user_id
    end

    add_index(:favorites, %i[user_id favorite_user_id], unique: true)
    add_index(:favorites, %i[favorite_user_id user_id], unique: true)
  end
end
