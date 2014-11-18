require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # should have_many(:users).through(:account_ownership)
  should belong_to(:school)

  should validate_presence_of(:name)
  should validate_presence_of(:section)
end
