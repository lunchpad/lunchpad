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
    @order_params = params[:order]
    @order_params.each do |order|
      @ami_id = order["ami_id"]
      @quantity = order["quantity"].to_i
      @item = AvailableMenuItem.find(@ami_id)
      @account.ordered_items.create(menu_item_id: @item.menu_item_id,
                                    delivery_date: @item.date,
                                    quantity: @quantity)
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

  def ordered_item_params
    params.require(:ordered_item).permit(:quantity)
  end

end
