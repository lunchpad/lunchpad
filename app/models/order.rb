class Order < ActiveRecord::Base
  resourcify
  belongs_to :account
  has_one :school, through: :account
  has_many :ordered_items, dependent: :destroy
  accepts_nested_attributes_for :ordered_items

  validates :account_id, presence: true

  def total
    subtotals.sum
  end

  def total_dollars
    Money.new(total).to_s
  end

  def copy(future_date)
    return nil unless (end_date..copyable_date).include? future_date
    weeks_to_copy = ((future_date - begin_date) / 7).to_i
    new_orders = Array.new
    (1..weeks_to_copy).each do |week|
      new_order = account.orders.create
      new_orders << new_order
      ordered_items.each do |item|
        copy_date = item.date.to_date + (week * 7)
        break unless copy_date <= [item.copyable_date,future_date].min
        item.copy(copy_date,new_order.id)
      end
      if new_order.end_date.cwday < 6
        remaining_items = AvailableMenuItem.within_date_range(new_order.end_date + 1,new_order.end_date.end_of_week)
        remaining_items.map { |ami| new_order.ordered_items.create(quantity: 0, available_menu_item_id: ami.id) }
      end
    end
    new_orders
  end

  def copyable_date
    ordered_items.map(&:copyable_date).min
  end

  def subtotals
    ordered_items.map { |item| item.subtotal }
  end

  def begin_date
    ordered_items.map(&:date).min.to_date
  end

  def end_date
    ordered_items.map(&:date).max.to_date
  end

  def weeks_between(start_date,end_date)
    ((end_date - start_date) / 7).to_i
  end
end
