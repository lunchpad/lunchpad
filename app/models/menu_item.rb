class MenuItem < ActiveRecord::Base
  has_many :available_menu_items
  belongs_to :vendor
  has_many :ordered_items
  has_many :accounts, through: :ordered_items

  validates :vendor_id,
            presence: true

  validates :name,
            presence: true,
            uniqueness: { scope: :vendor_id, case_sensitive: false }

  validates :description,
            presence: true

  validates :price,
            presence: true

  def schedule_availability(availability)
    begin_date = Date.parse(availability[:begin_date])
    end_date = Date.parse(availability[:end_date])
    date_range = begin_date..end_date
    date_range.each do |date|
      AvailableMenuItem.create(date: date, menu_item_id: id) if date.send(availability[:day_of_week].downcase + '?')
    end
  end
end
