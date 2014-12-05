require 'test_helper'

class MenuItemsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  def valid_menu_item_data
    { vendor_id: vendors(:one).id,
      name: 'Test Item',
      description: 'Test item description',
      price: 100 }
  end

  def valid_availability_data
    { begin_date: (Date.today.beginning_of_week + 7).to_s,
      end_date: (Date.today.beginning_of_week + 30).to_s,
      day_of_week: 'Tuesday' }
  end

  context 'GET menu_items#show' do
    setup { get :show, id: menu_items(:one) }

    should render_template('show')
    should respond_with(:success)

    should 'load menu_item' do
      assert assigns[:menu_item], 'Should load menu_item'
    end
  end

  context 'GET menu_items#new' do
    setup { get :new, vendor_id: vendors(:one) }

    should render_template('new')
    should respond_with(:success)

    should 'instantiate new menu_item object' do
      assert assigns[:menu_item], 'Should have a new menu_item'
    end
  end

  context 'GET menu_items#edit' do
    setup { get :edit, id: menu_items(:one) }

    should render_template('edit')
    should respond_with(:success)

    should 'load menu_item' do
      assert assigns[:menu_item], 'Should load menu_item'
      assert 'Item One', assigns[:menu_item].name
    end
  end

  context 'POST menu_items#create' do
    setup { post :create, { vendor_id: vendors(:one),
                            menu_item: valid_menu_item_data,
                            availability: valid_availability_data } }

    should 'create menu_item' do
      assert_saved_model(:menu_item)
    end

    should 'redirect to menu_item show' do
      assert assigns[:menu_item]
    end

    should 'create available menu items based on availability' do
      assert_equal 4, assigns[:menu_item].available_menu_items.count
    end
  end

  context 'PATCH menu_items#update' do
    setup { patch :update, { id: menu_items(:one), menu_item: valid_menu_item_data } }

    should 'update menu_item with new params' do
      @menu_item = MenuItem.find(menu_items(:one).id)
      assert_equal 'Test Item', @menu_item.name
      assert_equal 'Test item description', @menu_item.description
      assert_equal 10000, @menu_item.price
      assert_equal 100, @menu_item.price_dollars
    end
  end

  context 'DELETE menu_items#destroy' do
    setup { delete :destroy, id: menu_items(:one) }

    should 'remove menu_item from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        @menu_item = MenuItem.find(menu_items(:one).id)
      end
    end
  end
end
