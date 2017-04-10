# Migration adds patient_id to patient sets patient_id as integer
class AddPateintIdToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :patient_id, :integer
  end
end
