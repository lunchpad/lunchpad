require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should belong_to(:school)
  should have_many(:account_ownerships)
  should have_many(:users).through(:account_ownerships)
  should have_many(:orders)

  should validate_presence_of(:name)
  should validate_presence_of(:section)

  context 'Account class' do
    setup do
      @account = accounts(:one)
      @order = Order.create(account: @account)
      @order.ordered_items.create(quantity: 2, available_menu_item: available_menu_items(:one))
      @order.ordered_items.create(quantity: 3, available_menu_item: available_menu_items(:two))
    end

    should 'know if it has an order for a certain begin date' do
      assert @account.has_order_for(available_menu_items(:one).date.to_date), 'should know if it has order for begin date'
    end
  end
end
