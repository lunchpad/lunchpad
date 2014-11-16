require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { users(:one) }

  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email).case_insensitive

  should_not allow_value("BAD EMAIL").for(:email)
  should_not allow_value("@").for(:email)
  should_not allow_value("  example@example.com").for(:email)

  should have_secure_password

  # should have_and_belong_to_many(:schools)
  # should have_many(:orders)
  # should have_many(:accounts)


  context "a user" do
    subject { users(:one) }
    setup do
      @user = users(:one)

    end

    # should "be able..." do
    #   # assert_empty @user.tags
    #   # @user.tag_list = "ruby, activerecord"
    #   # assert_equal 2, @user.tags.count
    #   # assert_includes @user.tags.map(&:name), "ruby"
    #   # assert_includes @user.tags.map(&:name), "activerecord"
    # end

  end
end
