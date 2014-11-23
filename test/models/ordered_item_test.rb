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
  end
end
