require 'test_helper'

class OrderedItemsControllerTest < ActionController::TestCase
  def valid_ordered_item_data
    { account: accounts(:one),
      menu_item: menu_items(:one),
      delivery_date: "2014-11-17 11:23:57",
      quantity: 1 }
  end

  def orders_not_submitted
    @orders_not_submitted = []
    2.times do
      @orders_not_submitted << OrderedItem.new(account_id: accounts(:one).id,
                                               menu_item_id: rand(1..10),
                                               delivery_date: "2014-11-17 11:23:57")
    end
  end

  context 'GET ordered_items#index' do
    setup { get :index }

    should render_template('index')
    should respond_with(:success)

  end

  context 'POST ordered_items#create' do
    orders_not_submitted
    count = OrderedItem.count
    setup { post :create, @orders_not_submitted}
    assert_not_equal count, OrderedItem.count
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


