require 'test_helper'

class AvailableMenuItemTest < ActiveSupport::TestCase
  should belong_to(:menu_item)
  should belong_to(:school)
  should have_many(:ordered_items)

  should validate_presence_of(:date)

  context 'AvailableMenuItem class' do
    should 'be able to return all items within range' do
      @begin_date = Date.today.beginning_of_week + 9
      @end_date = Date.today.beginning_of_week + 10
      assert_equal 2, AvailableMenuItem.within_date_range(@begin_date,@end_date).count
    end

    should 'validate that it is not being set on an off day' do
      menu_item = menu_items(:one)
      availability = AvailableMenuItem.create(menu_item: menu_item, date: off_days(:one).date, school: schools(:one))

      assert availability.invalid?, 'cannot be scheduled on off day'
      assert_not_empty availability.errors[:blocked]
    end
  end
end
