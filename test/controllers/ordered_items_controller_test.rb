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

  test 'PATCH ordered_items#update' do
    @ordered_item = OrderedItem.find(ordered_items(:one).id)
    patch :update, { id: @ordered_item, ordered_item: {quantity: 2} }
    @ordered_item.reload
    assert_equal @ordered_item.quantity, 2
  end

  context 'DELETE ordered_items#destroy' do
    setup { delete :destroy, id: ordered_items(:one)}

    should 'remove ordered_item from DB' do
      assert_raise ActiveRecord::RecordNotFound do
        @ordered_item = OrderedItem.find(ordered_items(:one).id)
      end
    end
  end
end


