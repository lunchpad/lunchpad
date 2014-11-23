class OrderedItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ordered_item, only: [:update, :destroy]

  def new
    @ordered_item = OrderedItem.new
  end

  def update
    return unless @ordered_item.update(ordered_item_params)
    redirect_to account_ordered_items_path
  end

  def destroy
    return unless @ordered_item.destroy
    redirect_to account_ordered_items_path
  end

  private

  def set_ordered_item
    @ordered_item = OrderedItem.find(params[:id])
  end

  def ordered_item_params
    params.require(:ordered_item).permit(:quantity)
  end
end
