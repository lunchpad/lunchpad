class OrderedItem < ActiveRecord::Base
  resourcify
  belongs_to :available_menu_item
  belongs_to :order
  delegate :menu_item, :to => :available_menu_item, :allow_nil => true
  delegate :date, :to => :available_menu_item, :allow_nil => true
  delegate :account, :to => :order, :allow_nil => true
  after_create :credit_account
  after_update :update_account
  after_destroy :debit_account
  before_destroy :for_future_date?
  default_scope { order(created_at: :asc) }

  validates :available_menu_item_id,
            presence: true

  validates :quantity,
            presence: true

  def subtotal
    quantity * menu_item.price
  end

  def subtotal_dollars
    Money.new(subtotal).to_s
  end

  def self.build_menu(begin_date,end_date)
    available_menu_items = AvailableMenuItem.within_date_range(begin_date,end_date)
    available_menu_items.map { |order| OrderedItem.new(quantity: 0, available_menu_item_id: order.id) }
  end

  def copyable_date?
    available_menu_items = menu_item.available_menu_items.where('date >= ?', date.beginning_of_day).order('date ASC')
    max_date = available_menu_items.first.date.to_date
    available_menu_items[1..-1].each do |availability|
      if (availability.date.to_date - max_date).to_i.modulo(7) == 0
        break unless availability.date.to_date == max_date + 7
        max_date = availability.date.to_date
      end
    end
    max_date
  end

  def copy(copy_date,order_id)
    ami = AvailableMenuItem.where('date >= ? AND date <= ? AND menu_item_id = ?',
                                  copy_date.beginning_of_day, copy_date.end_of_day, available_menu_item.menu_item)
    OrderedItem.create(available_menu_item_id: ami[0].id, order_id: order_id, quantity: self.quantity)
  end

  private

  def credit_account
    account.increment!(:balance, subtotal)
  end

  def debit_account
    account.decrement!(:balance, subtotal)
  end

  def update_account
    quantities = changes[:quantity]
    change = (quantities[1] - quantities[0]) * menu_item.price
    account.increment!(:balance, change)
  end

  def for_future_date?
    cutoff_date = Date.parse('Monday')
    cutoff_date += 7 if cutoff_date < Date.today
    date >= cutoff_date
  end
end
