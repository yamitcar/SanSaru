class DeleteConfigsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :configs

    Event.all.each do |event|
      if(event.active)
        event.status = :activo.to_s
      else
        event.status = :finalizado.to_s
      end

      unless (event.tickets_left)
        event.tickets_left = event.participants
      end
      event.save!
    end

    remove_column :events, :active
  end
end
