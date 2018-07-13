class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :residence, null: false
      t.boolean :first_time, null: false
      t.string :expectancy, null: false
      t.belongs_to :agile, index: true
      t.string :agile_description, null: false
      t.string :hobbies
      t.string :bring
      t.string :proposal
      t.string :bio, null: false
      t.belongs_to :agileRelation, index: true
      t.belongs_to :gender, index: true
      t.belongs_to :size, index: true
      t.timestamps
    end
  end
end
