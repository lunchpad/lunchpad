class Account < ActiveRecord::Base
  resourcify
  belongs_to :school
  has_many :account_ownerships
  has_many :users, through: :account_ownerships
  has_many :orders, dependent: :destroy
  has_many :ordered_items, through: :orders

  monetize :balance, :as => 'balance_dollars'

  validates :name, presence: true
  validates :section, presence: true

  def has_order_for(begin_date)
    return false if orders.count == 0
    orders.select { |order| order.begin_date == begin_date }[0]
  end
end
