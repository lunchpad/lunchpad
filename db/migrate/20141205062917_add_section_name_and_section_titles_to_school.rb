class AddSectionNameAndSectionTitlesToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :section_name, :string
    add_column :schools, :section_titles, :string
  end
end
