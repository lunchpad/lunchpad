class MenuItem < ActiveRecord::Base
  belongs_to :vendor

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
