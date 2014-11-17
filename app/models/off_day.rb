class OffDay < ActiveRecord::Base
  belongs_to :school

  validates :name, presence: true
  validates :date, presence: true
end
