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

    should 'be able to get all subtotals in cents for related ordered items' do
      assert_equal [2000,1500], @order.subtotals, 'should multiple item quantity with menu item price'
    end

    should 'be able to get total cost in cents of all ordered items' do
      assert_equal 3500, @order.total, 'should total all subtotals'
    end

    should 'be able to get total cost in dollars of all ordered items' do
      assert_equal '35.00', @order.total_dollars, 'should total all subtotals'
    end

    should 'know the begin date for the order' do
      assert_equal available_menu_items(:one).date, @order.begin_date, 'should know date of first ordered item'
    end

    should 'repeat order given days in the future' do
      assert_difference 'Order.count',2 do
        order = Order.create(account: accounts(:one))
        order.ordered_items.create(available_menu_item: available_menu_items(:one), quantity: 1)
        order.copy(1)
      end
    end
  end
end
