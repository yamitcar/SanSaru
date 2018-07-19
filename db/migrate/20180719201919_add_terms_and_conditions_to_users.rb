class AddTermsAndConditionsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :terms_of_service, :boolean, default: false
  end
end
