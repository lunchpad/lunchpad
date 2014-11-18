class OrderedItem < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :account

  validates :menu_item_id,
            presence: true

  validates :account_id,
            presence: true

  validates :delivery_date,
            presence: true

  validates :quantity,
            presence: true,
            numericality: { greater_than_or_equal_to: 1 }
end
