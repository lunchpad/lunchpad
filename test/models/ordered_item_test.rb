require 'test_helper'

class OrderedItemTest < ActiveSupport::TestCase
  should belong_to(:order)
  should belong_to(:available_menu_item)

  should validate_presence_of(:available_menu_item_id)
  should validate_presence_of(:quantity)

  context 'Ordered Item class' do
    should 'be able to get subtotal for item' do
      order = Order.create(account: accounts(:one))
      ordered_item = OrderedItem.create(quantity: 2, order: order, available_menu_item: available_menu_items(:one))

      assert_equal 20, ordered_item.subtotal, 'should get array of subtotals for '
    end

    should 'after_create, update account balance with order subtotal' do
      assert_difference 'accounts(:one).reload.balance',10 do
        order = Order.create(account: accounts(:one))
        order.ordered_items.create(available_menu_item: available_menu_items(:one), quantity: 1)
      end
    end

    should 'after_update, update account balance with order subtotal' do
      assert_difference 'accounts(:one).reload.balance',30 do
        order = Order.create(account: accounts(:one))
        order.ordered_items.create(available_menu_item: available_menu_items(:one), quantity: 1)
        order.ordered_items.first.update(quantity: 3)
      end
    end
  end
end
