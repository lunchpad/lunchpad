class OrderedItemsController < ApplicationController

  def index
    @ordered_items = OrderedItem.all
  end

  def new
    @ordered_item = OrderedItem.new
  end

  def create
    @orders_not_submitted.each do |key, val|
      hash = params.require(key).permit(:quantity)
      val.update(quantity: hash[:quantity].to_i)
      val.save
    end
  end

  # def update
  #   return unless @ordered_item.update(ordered_item_params)
  # end

  # def destroy
  #   return unless @ordered_item.destroy
  # end

  private

  def ordered_item_params
    @orders_not_submitted.each do |key, val|
      params.require(key).permit(:quantity)
    end
  end

end
