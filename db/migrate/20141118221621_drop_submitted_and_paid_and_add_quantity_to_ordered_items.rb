class DropSubmittedAndPaidAndAddQuantityToOrderedItems < ActiveRecord::Migration
  def change
    remove_column :ordered_items, :submitted
    remove_column :ordered_items, :submitted_date
    remove_column :ordered_items, :paid
    remove_column :ordered_items, :paid_date
    add_column :ordered_items, :quantity, :integer
  end
end
