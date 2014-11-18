require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many(:accounts).through(:account_ownerships)
  should have_many(:account_ownerships)
end
