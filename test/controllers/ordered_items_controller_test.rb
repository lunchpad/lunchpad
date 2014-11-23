require 'test_helper'

class OrderedItemsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = User.create!(first_name: 'First',
                         last_name: 'Last',
                         email: 'firstlast@example.com',
                         password: 'password',
                         password_confirmation: 'password')
    sign_in @user
  end

  context 'GET ordered_items#new' do
    setup { get :new, account_id: accounts(:one).id }

    should render_template('new')
    should respond_with(:success)

    should 'instantiate new' do
      assert assigns[:ordered_item], 'should load new ordered item'
    end
  end

  test 'PATCH ordered_items#update' do
    @ordered_item = OrderedItem.find(ordered_items(:one).id)
    patch :update, { id: @ordered_item,
                     account_id: accounts(:one).id,
                     ordered_item: {quantity: 2} }
    @ordered_item.reload
    assert_equal @ordered_item.quantity, 2
  end

  context 'DELETE ordered_items#destroy' do
    setup { delete :destroy, account_id: accounts(:one).id, id: ordered_items(:one)}

    should 'remove ordered_item from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        @ordered_item = OrderedItem.find(ordered_items(:one).id)
      end
    end
  end
end


