class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :build_order_menu, only: [:new]
  before_action :set_account
  before_action :set_order, only: [:show]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @ordered_items = build_order_menu
  end

  def show
  end

  def create
    @order = @account.orders.build(order_params)

    if @order.save!
      redirect_to account_orders_path, success: 'Order was created.'
    else
      render :new
    end
  end

  private

  def build_order_menu
    dates = [params[:begin_date],params[:end_date]].map { |date| Date.parse(date) }
    available_menu_items = AvailableMenuItem.within_date_range(dates.first,dates.last)
    order_items = []
    available_menu_items.each do |order|
      order_items << OrderedItem.new(quantity: 0, available_menu_item_id: order.id)
    end
    order_items
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
