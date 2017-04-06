class AddAttachmentPosterToDoctors < ActiveRecord::Migration
  def self.up
    change_table :doctors do |t|
      t.attachment :poster
    end
  end

  def self.down
    remove_attachment :doctors, :poster
  end
end
