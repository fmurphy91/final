class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.text :address
      t.string :consultation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
