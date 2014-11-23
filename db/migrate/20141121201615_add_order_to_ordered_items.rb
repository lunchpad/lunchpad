class AddOrderToOrderedItems < ActiveRecord::Migration
  def change
    add_reference :ordered_items, :order, index: true
  end
end
