class CreateJoinTableMenuItemsOrders < ActiveRecord::Migration
  def change
    def change
      create_table :menu_items_orders, id: false do |t|
        t.integer :menu_items
        t.integer :orders
      end
    end
  end
end
