class OrderedItem < ActiveRecord::Base
  belongs_to :available_menu_item
  belongs_to :order
  delegate :menu_item, :to => :available_menu_item, :allow_nil => true
  delegate :date, :to => :available_menu_item, :allow_nil => true
  delegate :account, :to => :order, :allow_nil => true
  after_create :credit_account_balance
  after_update :update_account_balance
  after_destroy :debit_account_balance

  validates :available_menu_item_id,
            presence: true

  validates :quantity,
            presence: true

  def subtotal
    quantity * menu_item.price
  end

  private

  def credit_account_balance
    account.increment!(:balance, subtotal)
  end

  def debit_account_balance
    account.decrement!(:balance, subtotal)
  end

  def update_account_balance
    quantities = changes[:quantity]
    change = (quantities[1] - quantities[0]) * menu_item.price
    account.increment!(:balance, change)
  end
end
