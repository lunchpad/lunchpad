require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should belong_to(:account)
  should have_many(:ordered_items)

  should validate_presence_of(:account_id)
end
