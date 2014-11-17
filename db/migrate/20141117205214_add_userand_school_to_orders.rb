class AddUserandSchoolToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :user, index: true
    add_reference :orders, :school, index: true
  end
end
