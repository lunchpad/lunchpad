class CreateNewOrders < ActiveRecord::Migration
  def change
    create_table :new_orders do |t|
      t.references :account, index: true

      t.timestamps
    end
  end
end
