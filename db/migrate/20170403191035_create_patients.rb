class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :fullname
      t.string :birthdate
      t.string :telephone
      t.text :address
      t.text :infection
      t.text :injury
      t.text :observations
      t.decimal :cost
      t.text :requests

      t.timestamps
    end
  end
end
