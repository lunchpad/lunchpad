class Account < ActiveRecord::Base
  belongs_to :school
  has_many :account_ownerships
  has_many :users, through: :account_ownerships
  has_many :orders

  validates :name, presence: true
  validates :section, presence: true
end
