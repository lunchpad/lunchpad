class School < ActiveRecord::Base
  has_many :vendors
  has_many :off_days
  has_many :accounts

  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true
end
