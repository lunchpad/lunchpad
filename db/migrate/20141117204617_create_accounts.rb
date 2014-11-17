class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.references :school, index: true
      t.integer :balance
      t.string :name
      t.string :section

      t.timestamps
    end
  end
end
