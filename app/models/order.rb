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
    return false unless future_date > Date.today && future_date <= copyable_date?
    end_week = weeks_between(begin_date.to_date,future_date)
    (1..end_week).to_a.each do |week|
      new_order = account.orders.create
      ordered_items.each do |item|
        copy_date = item.date.to_date + (week * 7)
        break unless copy_date <= item.copyable_date?
        item.copy(item.date.to_date + (week * 7),new_order.id)
      end
    end
  end

  def copyable_date?
    max_dates = ordered_items.where('quantity > 0').map { |item| { max_date: item.copyable_date?, item: item } }
    max_dates.delete_if{ |max_dates| max_dates[:max_date] == nil }
    return begin_date.to_date if max_dates.empty?
    max_dates.min_by{ |max_dates| max_dates[:max_date] }[:max_date]
  end

  def subtotals
    ordered_items.map { |item| item.subtotal }
  end

  def begin_date
    ordered_items.first.date
  end

<<<<<<< HEAD
  # def lunch_coverage
  #   items_ordered = ordered_items.select {|oi| oi["quantity"] > 0 }
  #   days = items_ordered.map(&:date).uniq
  # end

end
=======
  def weeks_between(start_date,end_date)
    ((end_date - start_date) / 7).to_i
  end

end
>>>>>>> 781b6a1c4f229ee20bedcd8d15d77727866e090d
