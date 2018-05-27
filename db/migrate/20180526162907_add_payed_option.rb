class AddPayedOption < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :payed, :boolean, default: false
  end
end
