class OrderedItem < ActiveRecord::Base
  belongs_to :available_menu_item
  belongs_to :order
  delegate :menu_item, :to => :available_menu_item, :allow_nil => true
  delegate :date, :to => :available_menu_item, :allow_nil => true
  delegate :account, :to => :order, :allow_nil => true
  after_create :credit_account
  after_update :update_account
  after_destroy :debit_account
  before_destroy :for_future_date?

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

  private

  def for_future_date?
    cutoff_date = Date.parse('Monday')
    cutoff_date += 7 if cutoff_date < Date.today
    date >= cutoff_date
  end
end
