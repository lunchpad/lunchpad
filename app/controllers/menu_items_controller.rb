class MenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy, :calendar]
  before_action :set_vendor, only: [:new, :create, :edit]

  def show
    @menu_item = MenuItem.find(params[:id])
  end

  def new
    @menu_item = @vendor.menu_items.new
    @days = %w[Monday Tuesday Wednesday Thursday Friday]
  end

  def edit
  end

  def create
    @menu_item = @vendor.menu_items.new(menu_item_params)
    if @menu_item.save
      @menu_item.schedule_availability(*availability_params.values)
      redirect_to @vendor, success: 'Menu item was created.'
    else
      render :new
    end
  end

  def update
    return unless @menu_item.update(menu_item_params)
    redirect_to @menu_item
  end

  def destroy
    @vendor = @menu_item.vendor
    return unless @menu_item.destroy
    redirect_to @vendor, success: 'Menu item was removed.'
  end

  def calendar
    @calendar = set_calendar(@menu_item,params[:begin_date],params[:end_date],params[:style])
    respond_to do |format|
      if @calendar.values.exclude? nil
        format.js { render "shared/calendar", status: :created }
      end
    end
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
    @school = @menu_item.vendor.school
  end

  def set_vendor
    @vendor = Vendor.find(params[:vendor_id])
    @school = @vendor.school
  end

  def menu_item_params
    menu_item_params = params.require(:menu_item).permit(:vendor_id, :name, :description, :price)
    menu_item_params[:price] = menu_item_params[:price].to_f * 100
    menu_item_params
  end

  def availability_params
    params.require(:availability).permit(:begin_date,:end_date,:day_of_week)
  end

  def set_calendar(menu_item,begin_date = Date.today.beginning_of_month,end_date = Date.today.end_of_month,style = 'simple')
    begin_date = begin_date.to_date
    end_date = end_date.to_date
    events = menu_item.available_menu_items.sort_by{ |day| [day.date] }
    @calendar = { owner: menu_item, events: events, begin_date: begin_date, end_date: end_date, style: style }
  end
end
