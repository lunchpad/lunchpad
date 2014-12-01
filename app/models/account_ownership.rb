class AccountOwnership < ActiveRecord::Base
  resourcify
  belongs_to :user
  belongs_to :account
end
