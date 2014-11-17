require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  subject { schools(:one) }

  should have_many(:users)
  should have_many(:vendors)
  should have_many(:off_days)
  should have_many(:accounts)

  should validate_presence_of(:name)

end
