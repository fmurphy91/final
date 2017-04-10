class Appointment < ApplicationRecord
  # appointments associations/relationships , belongs_to user/patient
  belongs_to :user
  belongs_to :patient
end
