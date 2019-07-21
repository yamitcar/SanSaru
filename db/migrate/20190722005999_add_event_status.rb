class AddEventStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :status, :string, default: "activo"
    add_column :events, :tickets_left, :integer
  end
end
