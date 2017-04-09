# Setting admin to users adding a column admin with boolean set to false
class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, :default => false
  end
end
