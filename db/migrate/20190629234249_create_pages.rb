class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :path, unique: true
      t.text :content
      t.belongs_to :event, index: true

      t.timestamps
    end
  end
end
