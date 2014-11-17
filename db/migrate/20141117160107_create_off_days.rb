class CreateOffDays < ActiveRecord::Migration
  def change
    create_table :off_days do |t|
      t.string :name
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
