class RemoveAccountFromOrderedItem < ActiveRecord::Migration
  def change
    remove_column :ordered_items, :account_id
  end
end
