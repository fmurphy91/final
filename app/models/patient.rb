class Patient < ApplicationRecord
  def self.search(search_for)
    Patient.where("fullname like ?", "%" + search_for + "%")
  end
  has_many :appointments
  belongs_to :user
end
