# Migration used to assign admin user to enable admin email listed here to only destroy/delete paatient/appointments and doctor records
class UpdateUsers < ActiveRecord::Migration[5.0]
  def change
    @u = User.find_by( email: 'admin@doctor.com' )
    @u.update_attribute :admin, true
  end
end
