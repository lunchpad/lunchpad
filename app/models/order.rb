class Order < ActiveRecord::Base
  belongs_to :account
  has_many :ordered_items
  accepts_nested_attributes_for :ordered_items

  validates :account_id,
            presence: true

  def total
    sub_totals.sum
  end

  def sub_totals
    ordered_items.map { |item| item.sub_total }
  end
end