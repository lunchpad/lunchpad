class OrderedItem < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :account

  validates :submitted,
            presence: true

  validates :paid,
            presence: true

  validates :menu_item_id,
            presence: true

  validates :account_id,
            presence: true

  validates :delivery_date,
            presence: true
end
