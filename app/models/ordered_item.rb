class OrderedItem < ActiveRecord::Base
  belongs_to :available_menu_item
  belongs_to :order
  delegate :menu_item, :to => :available_menu_item, :allow_nil => true

  validates :available_menu_item_id,
            presence: true

  validates :quantity,
            presence: true

  def sub_total
    quantity * menu_item.price
  end
end
