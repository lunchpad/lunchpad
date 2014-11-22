require 'test_helper'

class AvailableMenuItemsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
    @account = Account.first
  end

  context 'GET available_menu_items#index' do
    setup { get :index, account_id: accounts(:one).id }

    should render_template('index')
    should respond_with(:success)

    should 'load available menu items' do
      assert assigns[:available_menu_items], 'Should load items'
    end
  end

  context 'GET available_menu_items#query' do
    setup { get :query, {account_id: accounts(:one).id,
                         begin_date: '2014-11-17',
                         end_date: '2014-11-18'  } }

    should render_template('query')
    should respond_with(:success)

    should 'load available menu items and new ordered items' do
      assert assigns[:available_menu_items], 'Should load available items'
      assert assigns[:orders_not_submitted], 'Should load new ordered items'
    end

    should 'only load items within range' do
      assert_equal 2, assigns[:available_menu_items].count, 'should only be two'
    end

    should 'only create one new ordered item for each available menu item' do
      assert_equal 2, assigns[:orders_not_submitted].count, 'should only be two'
    end
  end

  # context 'DELETE available_menu_items#destroy' do
    # setup { delete :destroy, account_id: accounts(:one).id, id: available_menu_items(:one) }
  #
  #   should 'remove vendor from DB' do
  #     assert_raise ActiveRecord::RecordNotFound do
  #       AvailableMenuItem.find(available_menu_items(:one).id)
  #     end
  #   end
  # end
end