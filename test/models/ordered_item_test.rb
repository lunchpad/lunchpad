require 'test_helper'

class OrderedItemTest < ActiveSupport::TestCase
  should belong_to(:order)
  should belong_to(:available_menu_item)

  should validate_presence_of(:available_menu_item_id)
  should validate_presence_of(:quantity)
end
