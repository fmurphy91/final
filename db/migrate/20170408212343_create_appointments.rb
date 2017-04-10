# Creating appointments functionality 
class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :firstname
      t.string :lastname
      t.string :birthdate
      t.string :telephone
      t.string :address
      t.string :time
      t.string :date

      t.timestamps
    end
  end
end
