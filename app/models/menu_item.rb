class MenuItem < ActiveRecord::Base
  has_many :availabilities
  belongs_to :vendor
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
end
