class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :school
  has_many :menu_items, through: :ordered_items

  validates :name, presence: true
  validates :section, presence: true
end
