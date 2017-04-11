class Patient < ApplicationRecord
  #search function for patient 'fullname' enables user to search a string of words for match
  def self.search(search_for)
    Patient.where("fullname like ?", "%" + search_for + "%")
  end
  #relationships/associations between the patient.. has_many appointments/users(doctors)
  has_many :appointments
  has_many :users
end
