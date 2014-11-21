class VendorsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
    @menu_items = @vendor.menu_items.all
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)

    render :new unless @vendor.save
    redirect_to @vendor, success: 'Vendor was created.'
  end

  def edit
  end

  def update
    return unless @vendor.update(vendor_params)
    redirect_to @vendor, success: 'Vendor was updated.'
  end

  def destroy
    return unless @vendor.destroy
    redirect_to vendors_path, success: 'Vendor was deleted.'
  end

  private

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name, :email, :phone_number)
  end
end
