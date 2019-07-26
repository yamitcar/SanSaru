class CreateCustomEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_emails do |t|
      t.string :name, null: false
      t.string :copy_to, null: false
      t.text :template, null: false
      t.belongs_to :event, index: true
      t.timestamps
    end

    Event.all.each do |event|
      event.add_invitation_email
    end
  end
end
