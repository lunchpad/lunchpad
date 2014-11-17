class Order < ActiveRecord::Base
  has_and_belongs_to_many :menu_items
  belongs_to :user
  belongs_to :school
end
