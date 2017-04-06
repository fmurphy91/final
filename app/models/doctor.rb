class Doctor < ApplicationRecord
  def self.search(search_for)
    Doctor.where("lastname like ?", "%" + search_for + "%")
  end
  has_attached_file :poster, styles: { medium: "200x200#" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
  belongs_to :user
end
