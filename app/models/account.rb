class Account < ActiveRecord::Base
  has_many :users, through: :account_ownership
  belongs_to :school
  has_many :menu_items, through: :ordered_items

  validates :name, presence: true
  validates :section, presence: true
end
