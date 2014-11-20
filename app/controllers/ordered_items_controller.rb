class OrderedItemsController < ApplicationController

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
  #   return unless @ordered_item.update(ordered_item_params)
  end

  def edit

  end

  # def destroy
  #   return unless @ordered_item.destroy
  # end
end
