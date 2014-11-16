class Vendor < ActiveRecord::Base
  has_many :menu_items

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[\w\-\.]+@[\w\-\.]+\Z/, message: 'must be a valid email address' }

  validates :phone_number,
            presence: true,
            format: { with: /\A\d{3}-\d{3}-\d{4}\Z/, message: 'must be formatted as ###-###-####' }
end
