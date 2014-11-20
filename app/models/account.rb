class Account < ActiveRecord::Base
  belongs_to :school
  has_many :account_ownerships
  has_many :users, through: :account_ownerships
  has_many :ordered_items
  has_many :menu_items, through: :ordered_items

  validates :name, presence: true
  validates :section, presence: true
  validates :user_id, presence: true
end
