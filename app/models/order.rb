class Order < ActiveRecord::Base
  has_and_belongs_to_many :menu_items
  belongs_to :user
  belongs_to :school

  validates :submitted,
            presence: true

  validates :paid,
            presence: true

  validates :user_id,
            presence: true

  validates :school_id,
            presence: true
end
