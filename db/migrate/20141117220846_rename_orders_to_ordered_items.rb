class RenameOrdersToOrderedItems < ActiveRecord::Migration
  def change
    rename_table :orders, :ordered_items
  end
end
