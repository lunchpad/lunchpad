class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :menu_item, index: true
      t.boolean :submitted, default: false
      t.boolean :paid, default: false
      t.datetime :submitted_date
      t.datetime :paid_date

      t.timestamps
    end
  end
end
