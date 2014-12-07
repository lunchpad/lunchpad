class MenuItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
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
    render :new unless @menu_item.save
    @menu_item.schedule_availability(availability_params)
    redirect_to @vendor, success: 'Menu item was created.'
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

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def set_vendor
    @vendor = Vendor.find(params[:vendor_id])
  end

  def menu_item_params
    menu_item_params = params.require(:menu_item).permit(:vendor_id, :name, :description, :price)
    menu_item_params[:price] = menu_item_params[:price].to_f * 100
    menu_item_params
  end

  def availability_params
    params.require(:availability).permit(:begin_date,:end_date,:day_of_week)
  end

end
