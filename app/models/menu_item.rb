class MenuItem < ActiveRecord::Base
  belongs_to :vendor
  has_and_belongs_to_many :orders

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
