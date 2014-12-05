class AccountOwnershipsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account, only: [:new, :create]
  before_action :set_account_ownership, only: [:destroy]

  def index
    @account_ownerships = AccountOwnership.all
  end

  def new
  end

  def create
    user = User.find_by_email(params[:user])
    if user.nil?
      flash[:notice] = "Cannot find User with that email address."
    else
      @account_ownership = @account.account_ownership.new(account_ownership_params)
      unless @account_ownership.save
        flash[:notice] = "This lunchbox was not shared with #{user.first_name} #{user.last_name}."
      end
    end
    redirect_to root_path
  end

  def destroy
    return unless @account_ownerships.destroy
    redirect_to root_path,  warning: "Are you sure you want to remove this account?"
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_account_ownership
    @account_ownerships = AccountOwnership.find(params[:id])
  end

  def account_ownership_params
    params.require(:account_ownership).permit(:account_id, :user_id)
  end
end
