json.extract! patient, :id, :fullname, :birthdate, :telephone, :address, :infection, :injury, :observations, :cost, :requests, :created_at, :updated_at
json.url patient_url(patient, format: :json)
