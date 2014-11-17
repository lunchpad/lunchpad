class Availability < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :school

  validates :date, presence: true
end
