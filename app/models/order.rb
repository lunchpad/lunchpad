class Order < ActiveRecord::Base
  belongs_to :account
  has_many :ordered_items
  accepts_nested_attributes_for :ordered_items

  validates :account_id,
            presence: true
end