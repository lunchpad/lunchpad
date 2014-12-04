class OrdersController < ApplicationController
  include CalendarHelper

  before_action :authenticate_user!
  before_action :set_account
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = @account.orders.sort_by(&:begin_date)
  end

  def new
    @order = Order.new
    @ordered_items = OrderedItem.build_menu(cutoff_date,cutoff_date + 4)
  end

  def create
    @order = @account.orders.build(order_params)
    if @order.save && @order.copy(params[:copy_date].to_date)
      redirect_to account_order_path(id: @order), success: 'Order was created.'
    else
      redirect_to new_account_order_path
    end
  end

  def edit
    @ordered_items = @order.ordered_items
  end

  def show
  end

  def update
    if @order.update(order_params)
      redirect_to account_order_path, success: 'Order was updated.'
    else
      redirect_to edit_account_order_path
    end
  end

  def destroy
    if @order.begin_date >= cutoff_date && @order.destroy
      redirect_to account_orders_path(@account), success: 'Order was cancelled.'
    else
      redirect_to account_order_path(id: @order), error: 'Order cannot be cancelled'
    end
  end

  def next

  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(ordered_items_attributes: [:quantity, :available_menu_item_id, :id])
  end
end
