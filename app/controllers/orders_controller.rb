class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, except: [:all]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  attr_reader :ordered_items

  def all
    @ordered_items = current_user.accounts.map{ |account| account.ordered_items.ordered_between }.flatten
    @ordered_items = @ordered_items.sort_by{ |item| [item.available_menu_item.date, item.account.name] }
  end

  def index
    @ordered_items = @account.ordered_items.ordered_between(Date.today.beginning_of_month.beginning_of_week,
                                                            Date.today.end_of_month.end_of_week).all
  end

  def new
    order_date = params[:order_date].to_date.monday
    if order_date >= cutoff_date
      @order = Order.new
      @ordered_items = OrderedItem.build_menu(order_date,order_date + 4).sort_by{ |item| [item.date, item.menu_item.name] }
      @copyable_date = @ordered_items.map{ |item| item.copyable_date }.select{ |date| date > order_date.end_of_week }.min
    else
      redirect_to account_orders_path, error: 'Order date is invalid.'
    end
  end

  def create
    @order = @account.orders.build(order_params)
    if @order.save && @order.copy(params[:copy_date].to_date)
      redirect_to account_order_path(id: @order), success: 'Order was created.'
    else
      redirect_to new_account_order_path, error: 'Your order is invalid.'
    end
  end

  def edit
    @ordered_items = @order.ordered_items
  end

  def show
    @ordered_items = @order.ordered_items.where('quantity > 0').sort_by{ |item| [item.date, item.menu_item.name] }
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
