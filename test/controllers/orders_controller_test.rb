require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
    @account = Account.first
  end

  def valid_items_attributes
    { '1' => { quantity: 1, available_menu_item_id: available_menu_items(:one).id },
      '2' => { quantity: 2, available_menu_item_id: available_menu_items(:two).id},
      '3' => { quantity: 0, available_menu_item_id: available_menu_items(:three).id } }
  end

  def invalid_items_attributes
    { '1' => { quantity: '', available_menu_item_id: '' },
      '2' => { quantity: '', available_menu_item_id: '' },
      '3' => { quantity: '', available_menu_item_id: '' } }
  end

  context 'GET orders#index' do
    setup { get :index, account_id: accounts(:one).id }

    should render_template('index')
    should respond_with(:success)

    should 'load orders' do
      assert assigns[:ordered_items], 'Should load ordered_items'
    end
  end

  context 'GET orders#new' do
    setup { get :new, { account_id: accounts(:one).id, order_date: Date.today.next_week(:monday) + 7 } }

    should render_template('new')
    should respond_with(:success)

    should 'load order' do
      assert assigns[:order], 'Should load order'
    end
  end

  context 'GET orders#show' do
    setup { get :show, { account_id: accounts(:one).id, id: orders(:one).id } }

    should render_template('show')
    should respond_with(:success)

    should 'load order' do
      assert assigns[:ordered_items], 'Should load ordered items'
    end
  end

  context 'GET orders#edit' do
    setup { get :edit, { account_id: accounts(:one).id, id: orders(:one).id } }

    should render_template('edit')
    should respond_with(:success)

    should 'load order' do
      assert assigns[:order], 'Should load order'
    end
  end

  context 'GET orders#update' do
    context 'when user enters valid attributes' do
      setup do
        updated_items_attributes = { '1' => { quantity: 2,
                                              available_menu_item_id: available_menu_items(:one).id,
                                              id: ordered_items(:one).id },
                                     '2' => { quantity: 2,
                                              available_menu_item_id: available_menu_items(:two).id,
                                              id: ordered_items(:two).id } }
        patch :update, { account_id: accounts(:one).id,
                         id: orders(:one).id,
                         order: { ordered_items_attributes: updated_items_attributes },
                         copy_date: Date.today.beginning_of_week + 14 }
      end

      should 'redirect to order show' do
        assert_redirected_to account_order_path
      end

      should 'save order' do
        assert_saved_model(:order)
      end

      should 'update quantity of items' do
        assert_equal 2, assigns[:order].ordered_items.first.quantity
        assert_equal 2, assigns[:order].ordered_items.second.quantity
      end
    end

    context 'when user does not enter valid attributes' do
      setup do
        updated_items_attributes = { '1' => { quantity: '',
                                              available_menu_item_id: '',
                                              id: ordered_items(:one).id },
                                     '2' => { quantity: '',
                                              available_menu_item_id: '',
                                              id: ordered_items(:two).id } }
        patch :update, { account_id: accounts(:one).id,
                         id: orders(:one).id,
                         order: { ordered_items_attributes: updated_items_attributes },
                         copy_date: Date.today.beginning_of_week + 14 }
      end

      should 'redirect to order show' do
        assert_redirected_to edit_account_order_path
      end
    end
  end

  context 'POST orders#create' do
    context 'when valid attributes are submitted' do
      setup { post :create, { account_id: accounts(:one).id,
                              order: { ordered_items_attributes: valid_items_attributes },
                              copy_date: Date.today.beginning_of_week + 14 } }

      should 'create order' do
        assert_saved_model(:order)
      end

      should 'order should have many ordered_items' do
        assert_equal 3, assigns[:order].ordered_items.count
      end
    end

    context 'when invalid attributes are submitted' do
      setup { post :create, { account_id: accounts(:one).id, order: { ordered_items_attributes: invalid_items_attributes } } }

      should 'should have invalid order' do
        assert_invalid_model(:order)
      end

      should 'redirect to new order' do
        assert_redirected_to new_account_order_path
      end
    end
  end

  context 'DELETE orders#destroy' do
    context 'If order is after cutoff date' do
      setup do
        @order = orders(:three)
      end

      should 'should destroy order' do
        assert_difference 'Order.count', -1 do
          delete :destroy, { account_id: accounts(:two).id, id: @order }
        end

        assert_nil OrderedItem.find_by(order: @order.id), 'should destroy ordered items'
        assert_redirected_to account_orders_path, 'should redirect to orders'
      end
    end

    context 'If order is before cutoff date' do
      should 'should not destroy order' do
        assert_no_difference 'Order.count' do
          delete :destroy, { account_id: @account, id: orders(:old).id }
        end

        assert_redirected_to account_order_path(@account, orders(:old)), 'should redirect to order'
      end
    end
  end
end
