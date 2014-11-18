require 'test_helper'

class AccountOwnershipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:account)
end
