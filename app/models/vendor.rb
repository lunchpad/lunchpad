class Vendor < ActiveRecord::Base
  resourcify
  has_many :menu_items
  has_many :ordered_items, through: :school
  belongs_to :school

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :email,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[\w\-\.]+@[\w\-\.]+\Z/, message: 'must be a valid email address' }

  validates :phone_number,
            format: { with: /\A\d{3}-\d{3}-\d{4}\Z/, message: 'must be formatted as ###-###-####' }

end
