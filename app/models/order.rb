class Order < ActiveRecord::Base
  resourcify
  belongs_to :account
  has_one :school, through: :account
  has_many :ordered_items, dependent: :destroy
  accepts_nested_attributes_for :ordered_items
  scope :items, self

  validates :account_id, presence: true

  def total
    subtotals.sum
  end

  def total_dollars
    Money.new(total).to_s
  end

  def copy(weeks_forward = 0)
    return true unless weeks_forward > 0
    (1..weeks_forward).each do |week|
      repeated_order = self.dup
      repeated_order.save
      self.ordered_items.each do |item|
        ami = AvailableMenuItem.where(date: item.date + (week * 7).days, menu_item_id: item.available_menu_item.menu_item)
        return unless ami.present?
        new_item = item.dup
        new_item.assign_attributes({ available_menu_item_id: ami[0].id, order_id: repeated_order.id, quantity: item.quantity })
        new_item.save
      end
    end
  end

  def subtotals
    ordered_items.map { |item| item.subtotal }
  end

  def begin_date
    ordered_items.first.date
  end

end