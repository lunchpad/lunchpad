class RenameNewOrderToOrder < ActiveRecord::Migration
  def change
    rename_table :new_orders, :orders
  end
end
