class CreateAccountOwnerships < ActiveRecord::Migration
  def change
    create_table :account_ownerships do |t|
      t.references :user, index: true
      t.references :account, index: true

      t.timestamps
    end
  end
end
