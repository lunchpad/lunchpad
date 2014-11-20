class OrderedItemsController < ApplicationController
  before_action :set_ordered_item, only: [:update, :destroy]

  def index
    @ordered_items = OrderedItem.all
  end

  def new
    @ordered_item = OrderedItem.new
  end

  def create
    @account = Account.first
    @order_params = params[:orders]
    @order_params.each do |order|
      quantity = order["quantity"].to_i
      date = Date.parse(order["delivery_date"])
      menu_item_id = order["menu_item_id"].to_i
      @account.ordered_items.create(menu_item_id: menu_item_id,
                                    delivery_date: date,
                                    quantity: quantity)
    end
    redirect_to ordered_items_path
  end

  def update
    return unless @ordered_item.update(ordered_item_params)
    redirect_to @ordered_item
  end

  def destroy
    return unless @ordered_item.destroy
    redirect_to ordered_items_path
  end

  private

  def set_ordered_item
    @ordered_item = OrderedItem.find(params[:id])
  end

<<<<<<< HEAD
  # def destroy
  #   return unless @ordered_item.destroy
  # end
=======
  def ordered_item_params
    params.require(:ordered_item).permit(:quantity)
  end

>>>>>>> c047aade062f05495e14e1f97d0161bad878abf9
end
