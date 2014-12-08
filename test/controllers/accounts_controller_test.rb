require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  def valid_data
  { user_id: users(:one).id,
    name: 'Student',
    section: 'Grade or Class'}
  end

  context "GET accounts#new without school" do
    setup { get :new }

    should render_template('new')
    should respond_with(:success)

  end

  context "GET accounts#new with school" do
    setup { get :new, { school: School.first } }

    should render_template('new')
    should respond_with(:success)

    should "instantiate new account if params are passed" do
      assert assigns[:account], 'Should be a new account'
    end
  end

  context 'POST accounts#create' do
    setup { post :create, { user_id: users(:one), account: valid_data } }

    should 'create account' do
      assert_saved_model(:account)
    end

    should 'save account' do
      assert_not_nil assigns[:account]
    end

    should 'redirect to root' do
      assert_redirected_to root_path
    end
  end

  context 'GET accounts#show' do
    setup { get :show, id: accounts(:one) }

    should render_template('show')
    should respond_with(:success)

    should 'load account' do
      assert assigns[:account], 'Should load account'
    end
  end

  context 'GET accounts#edit' do
    setup { get :edit, id: accounts(:one) }

    should render_template('edit')
    should respond_with(:success)

    should 'load account' do
      assert assigns[:account], 'Should load account'
      assert 'FirstAccount', assigns[:account].name
    end
  end

  context 'PATCH accounts#update' do
    setup { patch :update, { id: accounts(:one), account: valid_data } }

    should 'update account' do
      @account = Account.find(accounts(:one).id)
      assert_equal 'Student', @account.name
      assert_equal 'Grade or Class', @account.section
    end
  end

end
