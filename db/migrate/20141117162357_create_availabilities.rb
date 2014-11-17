class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :date
      t.references :menu_item, index: true

      t.timestamps
    end
  end
end
