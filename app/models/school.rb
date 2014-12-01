class School < ActiveRecord::Base
  resourcify
  has_many :vendors
  has_many :off_days
  has_many :accounts
  has_many :orders, through: :accounts
  has_many :ordered_items, through: :orders
  has_many :menu_items
  has_many :available_menu_items


  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true
end
