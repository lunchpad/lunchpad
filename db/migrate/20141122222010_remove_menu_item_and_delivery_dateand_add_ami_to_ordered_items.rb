class RemoveMenuItemAndDeliveryDateandAddAmiToOrderedItems < ActiveRecord::Migration
  def change
    remove_column :ordered_items, :menu_item_id
    remove_column :ordered_items, :delivery_date
    add_reference :ordered_items, :available_menu_item, index: true
  end
end
