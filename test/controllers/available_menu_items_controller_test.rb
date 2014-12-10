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

  context 'DELETE available_menu_items#destroy' do
    setup { delete :destroy, { account_id: accounts(:one).id,
                               id: available_menu_items(:one).id,
                               menu_item_id: available_menu_items(:one).menu_item } }

    should 'remove vendor from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        AvailableMenuItem.find(available_menu_items(:one).id)
      end
    end
  end
end