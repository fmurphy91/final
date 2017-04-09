class Doctor < ApplicationRecord
  # search function for doctor 'lastname', enables user to search doctor by lastname by string match
  def self.search(search_for)
    Doctor.where("lastname like ?", "%" + search_for + "%")
  end
  # Allows paperclip to work is needed to attach the picture file which I named :poster and set at 200x200
  has_attached_file :poster, styles: { medium: "200x200#" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
  # Doctor association/relationship with user (belongs_to)
  belongs_to :user
end
