require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  should have_many(:menu_items)
  should belong_to(:school)

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  should validate_uniqueness_of(:email).case_insensitive
  should_not allow_value('INVALID EMAIL').for(:email)
  should_not allow_value('@').for(:email)
  should_not allow_value('  invalid@example.com').for(:email)

  should_not allow_value('5555555555').for(:phone_number)
  should_not allow_value('(555)555-5555').for(:phone_number)
  should allow_value('555-555-5555').for(:phone_number)
end
