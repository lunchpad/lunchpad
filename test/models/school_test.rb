require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  subject { schools(:one) }

  should_eventually have_many(:users)
  should belong_to(:user)
  should have_many(:vendors)
  should have_many(:off_days)
  should have_many(:accounts)

  should validate_presence_of(:name)
  should validate_presence_of(:phone)
  should validate_presence_of(:address)

end
