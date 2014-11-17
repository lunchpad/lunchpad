class AddSchoolToVendors < ActiveRecord::Migration
  def change
    add_reference :vendors, :school, index: true
  end
end
