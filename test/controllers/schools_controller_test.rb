require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def create_regular_user
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  def create_school_admin
    @admin = User.create!(first_name: 'First',
                          last_name: 'Last',
                          email: 'admin@example.com',
                          password: 'password',
                          password_confirmation: 'password')
    @admin.add_role :admin, schools(:one)
    sign_in @admin
  end

end
