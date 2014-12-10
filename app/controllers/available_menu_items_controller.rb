class AvailableMenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school_and_menu_item, only: [:create, :destroy]
  before_action :set_available_menu_item, only: :destroy

  def index
    @available_menu_items = AvailableMenuItem.all
  end

  def destroy
    return unless @available_menu_item.destroy
    redirect_to menu_item_path(@menu_item)
  end

  def create
    @date = params[:date]
    @available_menu_item = @menu_item.available_menu_items.create(date: @date,
                                                                  school: @school)
    redirect_to menu_item_path(@menu_item)
  end

  private

  def set_available_menu_item
    @available_menu_item = AvailableMenuItem.find(params[:id])
  end

  def set_school_and_menu_item
    @menu_item = MenuItem.find(params[:menu_item_id])
    @school = @menu_item.school
  end
end


