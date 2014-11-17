class AddPhoneAndAddressToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :phone, :string
    add_column :schools, :address, :string
  end
end
