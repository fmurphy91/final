json.extract! appointment, :id, :firstname, :lastname, :birthdate, :telephone, :address, :time, :date, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
