require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should belong_to(:school)
  should have_many(:account_ownerships)
  should have_many(:users).through(:account_ownerships)
  should have_many(:ordered_items)
  should have_many(:menu_items).through(:ordered_items)

  should validate_presence_of(:name)
  should validate_presence_of(:section)
  should validate_presence_of(:user_id)
end
