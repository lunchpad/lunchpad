class AvailableMenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_available_menu_item, only: [:destroy]

  def index
    @available_menu_items = AvailableMenuItem.all
  end

  def destroy
    return unless @available_menu_item.destroy
    redirect_to account_available_menu_items_path
  end

  private

  def set_available_menu_item
    @available_menu_item = AvailableMenuItem.find(params[:id])
  end
end


