class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.references :vendor, index: true
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
