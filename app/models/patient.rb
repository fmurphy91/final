class Patient < ApplicationRecord
  def self.search(search_for)
    Patient.where("fullname like ?", "%" + search_for + "%")
  end
  has_many :appointments
  has_many :users
end
