class AddMentorOption < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :need_mentor, :boolean, default: false
  end
end
