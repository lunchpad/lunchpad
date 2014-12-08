require 'test_helper'

class ChargesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  context 'GET charges#new' do
    setup { get :new }

    should render_template('new')
    should respond_with(:success)
  end
end
