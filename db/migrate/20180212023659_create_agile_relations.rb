class CreateAgileRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :agile_relations do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
