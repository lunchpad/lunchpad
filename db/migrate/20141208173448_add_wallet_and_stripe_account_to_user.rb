class AddWalletAndStripeAccountToUser < ActiveRecord::Migration
  def change
    add_column :users, :wallet, :integer, :default => 0
    add_column :users, :stripe_id, :string
  end
end
