require 'test_helper'

class VendorsControllerTest < ActionController::TestCase
  def valid_vendor_data
    { name: 'Test User',
      email: 'test@example.com',
      phone_number: '111-111-1111' }
  end

  context 'GET vendors#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)

    should 'load vendors' do
      assert assigns[:vendors], 'Should load vendors'
    end
  end

  context 'GET vendors#show' do
    setup { get :show, id: vendors(:one) }

    should render_template('show')
    should respond_with(:success)

    should 'load vendor' do
      assert assigns[:vendor], 'Should load vendor'
    end

    should 'instantiate menu item' do
      assert assigns[:menu_item], 'Should have a new menu item'
    end
  end

  context 'GET vendors#new' do
      setup { get :new }

      should render_template('new')
      should respond_with(:success)

      should 'instantiate new vendor object' do
        assert assigns[:vendor], 'Should have a new vendor'
      end
  end

  context 'GET vendors#edit' do
    setup { get :edit, id: vendors(:one) }

    should render_template('edit')
    should respond_with(:success)

    should 'load vendor' do
      assert assigns[:vendor], 'Should load vendor'
      assert 'User One', assigns[:vendor].name
    end
  end

  context 'POST vendors#create' do
    setup { post :create, { vendor: valid_vendor_data } }

    should 'create vendor' do
      assert_saved_model(:vendor)
    end

    should 'redirect to vendor show' do
      assert assigns[:vendor]
    end
  end

  context 'PATCH vendors#update' do
    setup { patch :update, { id: vendors(:one), vendor: valid_vendor_data } }

    should 'update vendor with new params' do
      @vendor = Vendor.find(vendors(:one).id)
      assert_equal 'Test User', @vendor.name
      assert_equal 'test@example.com', @vendor.email
      assert_equal '111-111-1111', @vendor.phone_number
    end
  end

  context 'DELETE vendors#destroy' do
    setup { delete :destroy, id: vendors(:one) }

    should 'remove vendor from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        @vendor = Vendor.find(vendors(:one).id)
      end
    end
  end
end
