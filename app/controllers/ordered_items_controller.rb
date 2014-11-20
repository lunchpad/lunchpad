class OrderedItemsController < ApplicationController

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
  #   return unless @ordered_item.update(ordered_item_params)
  end

  def edit

  end

  # def destroy
  #   return unless @ordered_item.destroy
  # end

end
