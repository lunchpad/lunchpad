class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, except: [:all]
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :set_ordered_items, only: [:show]
  before_action :check_prior_order, only: [:new]

  attr_reader :ordered_items

  def all
    begin_date = params[:begin_date].try(:to_date) || Date.today.beginning_of_month
    end_date = params[:end_date].try(:to_date) || Date.today.end_of_month
    ordered_items = current_user.accounts.map{ |account| account.ordered_items.ordered_between(begin_date.beginning_of_week,end_date.end_of_week) }.flatten
    ordered_items = ordered_items.sort_by{ |item| [item.available_menu_item.date, item.account.name] }
    @calendar = { events: ordered_items, begin_date: begin_date, end_date: end_date, style: 'detail_all' }
  end

  def index
    ordered_items = @account.ordered_items.ordered_between(Date.today.beginning_of_month.beginning_of_week,
                                                            Date.today.end_of_month.end_of_week).all
    @ordered_items = ordered_items.sort_by{ |item| [item.date, item.menu_item.name] }
  end

  def new
    @order_date = params[:order_date].to_date.monday
    if @order_date >= cutoff_date && OrderedItem.build_menu(@order_date,@order_date + 4).present?
      @order = Order.new(account: @account)
      @ordered_items = @order.build_menu(@order_date,@order_date + 4).sort_by{ |item| [item.date, item.menu_item.name] }
    else
      redirect_to root_path, error: 'Order date is invalid.'
    end
  end

  def create
    @order = @account.orders.build(order_params)
    @copies = @order.copy(params[:copy_date].to_date) unless params[:copy_date].nil?
    if @order.save && (params[:copy_date].empty? || @copies)
        redirect_to account_orders_path(id: [@order, @copies].flatten.compact), success: 'Order was created.'
    else
      redirect_to new_account_order_path(order_date: params[:order_date]), error: 'Your order is invalid.'
    end
  end

  def edit
    @ordered_items = @order.ordered_items
  end

  def show
    @ordered_items = @ordered_items.select { |item| item.quantity > 0 }.sort_by{ |item| [item.date, item.menu_item.name] }
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

  def set_ordered_items
    orders = Order.find(params[:id].split('/'))
    @ordered_items = orders.map{ |order| order.ordered_items }.flatten
  end

  def order_params
    params.require(:order).permit(ordered_items_attributes: [:quantity, :available_menu_item_id, :id])
  end

  def check_prior_order
    previous_items = @account.ordered_items.ordered_between(params[:order_date].to_date.beginning_of_week,params[:order_date].to_date.end_of_week)
    return unless previous_items.size > 0
    @order = previous_items.first.order
    redirect_to edit_account_order_path(@account, @order)
  end
end
