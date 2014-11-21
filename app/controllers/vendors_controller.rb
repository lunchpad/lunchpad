class VendorsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all
  end

  def show
    @menu_item = MenuItem.new
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to action: "index", success: 'Vendor was created.'
    else
      render :new, alert: "Please try again."
    end
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to action: "index", success: 'Vendor was updated.'
    else
      render :edit, alert: "Please try again."
    end
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
