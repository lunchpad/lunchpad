require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:accounts).through(:account_ownerships)
  should have_many(:account_ownerships)

  context 'User class' do
    setup do
      @user = users(:one)
    end

    should 'know the aggregate balance of all associated accounts' do
      assert_equal 2, users(:one).balance
    end
  end
end
