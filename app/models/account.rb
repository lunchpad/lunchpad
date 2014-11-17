class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :school

  validates :name, presence: true
  validates :section, presence: true
end
