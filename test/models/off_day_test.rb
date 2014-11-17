require 'test_helper'

class OffDayTest < ActiveSupport::TestCase
  should belong_to(:school)

  should validate_presence_of(:name)
  should validate_presence_of(:date)
end
