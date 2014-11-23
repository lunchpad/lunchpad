class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_order, only: [:show]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @ordered_items = build_order_menu
  end

  def create
    @order = @account.orders.build(order_params)

    if @order.save
      redirect_to account_order_path(id: @order.id), success: 'Order was created.'
    else
      redirect_to new_account_order_path(begin_date: params[:begin_date], end_date: params[:end_date])
    end
  end

  private

  def build_order_menu
    available_menu_items = AvailableMenuItem.within_date_range(Date.parse(params[:begin_date]),Date.parse(params[:end_date]))
    @ordered_items = available_menu_items.map { |order| OrderedItem.new(quantity: 0, available_menu_item_id: order.id) }
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(ordered_items_attributes: [:quantity, :available_menu_item_id])
  end
end
