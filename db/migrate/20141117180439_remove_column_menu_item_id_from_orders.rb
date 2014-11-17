class RemoveColumnMenuItemIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :menu_item_id
  end
end
