require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should have_and_belong_to_many(:menu_items)
  should belong_to(:user)
  should belong_to(:school)

  should validate_presence_of(:submitted)
  should validate_presence_of(:paid)
  should validate_presence_of(:user_id)
  should validate_presence_of(:school_id)
end
