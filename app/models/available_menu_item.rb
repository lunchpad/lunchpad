class AvailableMenuItem < ActiveRecord::Base
  resourcify
  belongs_to :menu_item
  belongs_to :school
  has_many :ordered_items

  validates :date, presence: true
  validates :menu_item, presence: true
  validate :date_cannot_be_on_off_day

  def date_cannot_be_on_off_day
    return unless school.present?
    if self.school.off_days.pluck(:date).map(&:to_date).include? self.date.to_date
      errors.add(:blocked, "can't be scheduled on an off day")
    end
  end

  def self.within_date_range(begin_date,end_date)
    where(:date => begin_date.beginning_of_day..end_date.end_of_day).order(:date)
  end
end
