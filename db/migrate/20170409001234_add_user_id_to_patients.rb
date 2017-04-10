# Migration adds user_id to patient sets user_id as integer
class AddUserIdToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :user_id, :integer
  end
end
