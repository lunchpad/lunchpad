require 'test_helper'

class OrderedItemsControllerTest < ActionController::TestCase

  context 'GET ordered_items#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)
  end

  test 'POST create takes array of params and creates ordered items' do
    assert_difference('OrderedItem.count', 3) do
      post :create, { order: [{ ami_id: "113629430", quantity: 1 },
                              { ami_id: "298486374", quantity: 2 },
                              { ami_id: "980190962", quantity: 3} ] }
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


