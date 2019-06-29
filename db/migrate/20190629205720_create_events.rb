class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :fullname, null: false
      t.string :site, null: false
      t.string :support_mail, null: false
      t.integer :participants, null: false
      t.decimal :price, :precision => 8, :scale => 2,null: false
      t.decimal :reserve_price, :precision => 8, :scale => 2
      t.decimal :ideal_price, :precision => 8, :scale => 2
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :venue, null: false
      t.string :venue_location, null: false
      t.string :monkeys, null: false
      t.timestamps
    end
  end
end
