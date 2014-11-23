require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
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

  def ordered_items_attributes
    { '1' => { quantity: 1,
               available_menu_item_id: available_menu_items(:one).id },
      '2' => { quantity: 2,
               available_menu_item_id: available_menu_items(:two).id},
      '3' => { quantity: 0,
               available_menu_item_id: available_menu_items(:three).id } }
  end

  context 'GET orders#index' do
    setup { get :index, account_id: accounts(:one).id }

    should render_template('index')
    should respond_with(:success)

    should 'load orders' do
      assert assigns[:orders], 'Should load orders'
    end
  end

  context 'GET orders#new' do
    setup { get :new, {account_id: accounts(:one).id,
                         begin_date: '2014-11-17',
                         end_date: '2014-11-18'  } }

    should render_template('new')
    should respond_with(:success)

    should 'load order' do
      assert assigns[:order], 'Should load order'
    end
  end

  context 'GET orders#new' do
    setup { get :new, {account_id: accounts(:one).id,
                       begin_date: '2014-11-17',
                       end_date: '2014-11-18'  } }

    should render_template('new')
    should respond_with(:success)

    should 'load order' do
      assert assigns[:order], 'Should load order'
    end
  end

  context 'POST orders#create' do
    setup { post :create, { account_id: accounts(:one).id, order: { ordered_items_attributes: ordered_items_attributes } } }

    should 'create order' do
      assert_saved_model(:order)
    end

    should 'order should have many ordered_items' do
      assert_equal 3, assigns[:order].ordered_items.count
    end
  end
end
