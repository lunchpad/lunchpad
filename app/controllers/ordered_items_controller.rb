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
    # binding.pry
    # # @orders_not_submitted.each do |key, value|
    # #   hash = params.require(key).permit(:quantity)
    # #   value.update(quantity: hash[:quantity].to_i)
    # #   value.save
    # # end
    # params[:order].each do |ami_id,quantity|
    #   p ami_id.to_i
    #   p quantity.to_i
    # end
    binding.pry
    redirect_to ordered_items_path

    # post :create, { ami_id: "113629430", quantity: 1 }, { ami_id: "298486374", quantity: 2 }

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
