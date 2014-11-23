require 'test_helper'

class MenuItemTest < ActiveSupport::TestCase
  should belong_to(:vendor)
  should have_many(:available_menu_items)

  should validate_presence_of(:vendor_id)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive.scoped_to(:vendor_id)
  should validate_presence_of(:description)
  should validate_presence_of(:price)
end
