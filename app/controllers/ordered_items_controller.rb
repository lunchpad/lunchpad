class OrderedItemsController < ApplicationController

  before_action :authenticate_user!
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
    redirect_to account_ordered_items_path
  end

  def update
    return unless @ordered_item.update(ordered_item_params)
    redirect_to account_ordered_items_path
  end

  def destroy
    return unless @ordered_item.destroy
    redirect_to account_ordered_items_path
  end

  private

  def set_ordered_item
    @ordered_item = OrderedItem.find(params[:id])
  end

  def ordered_item_params
    params.require(:ordered_item).permit(:quantity)
  end
end
