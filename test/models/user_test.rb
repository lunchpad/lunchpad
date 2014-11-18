require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_and_belong_to_many(:schools)
  should have_many(:orders)
  should have_many(:accounts)


  context "a user" do
    subject { users(:one) }
    setup do
      @user = users(:one)

    end

    # should "be able..." do
    # end

  end
end
