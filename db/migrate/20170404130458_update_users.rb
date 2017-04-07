class UpdateUsers < ActiveRecord::Migration[5.0]
  def change
    @u = User.find_by( email: 'admin@gmail.com' )
    @u.update_attribute :admin, true
  end
end
