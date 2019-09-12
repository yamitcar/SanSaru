class ChangeAdminType < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_type, :string, default: 'participant'
    User.where(admin: true).each do |user|
      user.user_type = :admin.to_s
      user.save!
    end
    remove_column :users, :admin
  end
end
