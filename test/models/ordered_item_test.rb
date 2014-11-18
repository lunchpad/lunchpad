require 'test_helper'

class OrderedItemTest < ActiveSupport::TestCase
  should belong_to(:menu_item)
  should belong_to(:account)

  should validate_presence_of(:submitted)
  should validate_presence_of(:paid)
  should validate_presence_of(:menu_item_id)
  should validate_presence_of(:account_id)
  should validate_presence_of(:delivery_date)

  # context 'Ordered Item class' do
  #   should 'be able to query for all orders that have not been submitted' do
  #     ordered_items = OrderedItem.not_submitted
  #     assert_includes ordered_items, ordered_items(:one)
  #
  #     ordered_items.each do |ordered_item|
  #       assert_not ordered_item.submitted
  #     end
  #   end
  # end
end
