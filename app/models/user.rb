class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts, through: :account_ownerships
  has_many :account_ownerships

  validates :first_name, presence: :true
  validates :last_name, presence: :true

  def balance
    accounts.pluck(:balance).sum
  end

  def balance_dollars
    Money.new(balance).to_s
  end

end