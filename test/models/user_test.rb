require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:accounts).through(:account_ownerships)
  should have_many(:account_ownerships)

  context 'User class' do
    setup do
      @user = users(:one)
    end

    should 'know the aggregate balance in cents of all associated accounts' do
      assert_equal 20000, users(:one).balance
    end

    should 'get the aggregate balance in dollars of all associated accounts' do
      assert_equal '200.00', users(:one).balance_dollars
    end
  end
end
