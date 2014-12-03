class AddAttachmentLogoToSchools < ActiveRecord::Migration
  def self.up
    change_table :schools do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :schools, :logo
  end
end
