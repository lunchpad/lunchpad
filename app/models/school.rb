class School < ActiveRecord::Base
  has_many :users
  has_many :vendors
  has_many :days_off
  has_many :accounts

end
