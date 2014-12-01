class OffDay < ActiveRecord::Base
  resourcify
  belongs_to :school

  validates :name, presence: true
  validates :date, presence: true
end
