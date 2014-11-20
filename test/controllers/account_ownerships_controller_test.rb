require 'test_helper'

class AccountOwnershipsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  context 'GET account_ownerships#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)

    should 'load available account ownerships' do
      assert assigns[:account_ownerships], 'Should load connections'
    end
  end

  context 'POST account_ownerships#create' do
    setup { post :create, { account_ownership: { user_id: users(:one).id,
                                                 account_id: accounts(:one).id } } }

    should 'create an account_ownership' do
      assert_saved_model(:account_ownership)
    end

    should 'redirect to "/welcome"' do
      assert assigns[:account_ownership]
    end
  end

  context 'DELETE account_ownerships#destroy' do
    setup { delete :destroy, id: account_ownerships(:one) }

    should 'remove account_ownerships from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        @account_ownership = AccountOwnership.find(account_ownerships(:one).id)
      end
    end
  end
end
