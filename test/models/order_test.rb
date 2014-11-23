require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should belong_to(:account)
  should have_many(:ordered_items)

  should validate_presence_of(:account_id)

  context 'Order class' do
    setup do
      @order = Order.create(account: accounts(:one))
      @order.ordered_items.create(quantity: 2, available_menu_item: available_menu_items(:one))
      @order.ordered_items.create(quantity: 3, available_menu_item: available_menu_items(:two))
    end

    should 'be able to get all subtotals for related ordered items' do
      assert_equal [20,15], @order.subtotals, 'should multiple item quantity with menu item price'
    end

    should 'be able to get total cost of all ordered items' do
      assert_equal 35, @order.total, 'should total all subtotals'
    end
  end
end
