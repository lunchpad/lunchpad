class OrderedItemsController < ApplicationController
  def index
    @ordered_items = OrderedItem.all
  end

  def new
    @ordered_item = OrderedItem.new
  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  def ordered_items_params
    params.require(:ordered_item).permit(:quantity)
  end

end
