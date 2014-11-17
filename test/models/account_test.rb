require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:school)

  should validate_presence_of(:name)
  should validate_presence_of(:section)
end
