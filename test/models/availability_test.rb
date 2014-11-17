require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  should belong_to(:menu_item)
  should belong_to(:school)
end
