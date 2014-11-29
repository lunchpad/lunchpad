class Order < ActiveRecord::Base
  belongs_to :account
  has_many :ordered_items, dependent: :destroy
  accepts_nested_attributes_for :ordered_items

  validates :account_id,
            presence: true

  def total
    subtotals.sum
  end

  def total_dollars
    Money.new(total).to_s
  end

  def subtotals
    ordered_items.map { |item| item.subtotal }
  end

  def begin_date
    ordered_items.first.date
  end
end