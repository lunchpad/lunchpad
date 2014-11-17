class AddAccountMenuItemAndDeliveryDateToOrderedItems < ActiveRecord::Migration
  def change
    add_reference :ordered_items, :account, index: true
    add_reference :ordered_items, :menu_item, index: true
    add_column :ordered_items, :delivery_date, :datetime
  end
end
