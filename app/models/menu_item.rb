class MenuItem < ActiveRecord::Base
  resourcify
  has_many :ordered_items, through: :available_menu_items
  has_many :available_menu_items
  belongs_to :vendor
  belongs_to :school
  monetize :price, :as => 'price_dollars'

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
    (begin_date..end_date).each do |date|
      available_menu_items.create(date: date, school: vendor.school) if date.send(availability[:day_of_week].downcase + '?')
    end
  end

  def available_on(date)
    self.available_menu_items.where("date = ?", date)
  end
end
