class User < ActiveRecord::Base
  has_and_belongs_to_many :schools
  has_many :orders
  has_many :accounts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX, message: "must be a valid email address" }

  has_secure_password
end
