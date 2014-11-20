require 'test_helper'

class OrderedItemsControllerTest < ActionController::TestCase

  context 'GET ordered_items#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)
  end

  context 'GET ordered_items#new' do
    setup { get :new }

    should render_template('new')
    should respond_with(:success)

    should 'instantiate new' do
      assert assigns[:ordered_item], 'should load new ordered item'
    end
  end

  test 'POST create takes array of params and creates ordered items' do
    assert_difference('OrderedItem.count', 3) do
      post :create, { orders: [{ quantity: 1,
                                delivery_date: available_menu_items(:one).date,
                                menu_item_id: available_menu_items(:one).id},
                              { quantity: 2,
                                delivery_date: available_menu_items(:two).date,
                                menu_item_id: available_menu_items(:two).id},
                              { quantity: 3,
                                delivery_date: available_menu_items(:three).date,
                                menu_item_id: available_menu_items(:three).id} ] }
    end

  end

  # context 'PATCH ordered_items#update' do
  #   setup { patch :update, { id: ordered_items(:one), quantity: 10} }
  #
  #   should 'update ordered item with new quantity' do
  #     @ordered_item = OrderedItem.find(ordered_items(:one).id)
  #     assert_equal 10, @ordered_item.quantity
  #   end
  # end

  # context 'DELETE ordered_items#destroy' do
  #   setup { delete :destroy, id: ordered_items(:one)}
  #
  #   should 'remove ordered_item from DB' do
  #     assert_raise ActiveRecord::RecordNotFound do
  #       @ordered_item = OrderedItem.find(ordered_items(:one).id)
  #     end
  #   end
  # end
end


