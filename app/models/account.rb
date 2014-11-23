class Account < ActiveRecord::Base
  resourcify
  belongs_to :school
  has_many :account_ownerships
  has_many :users, through: :account_ownerships
  has_many :orders

  validates :name, presence: true
  validates :section, presence: true

  def has_order_for(begin_date)
    orders.select { |order| order.begin_date == begin_date }[0]
  end
end
