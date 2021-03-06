class AccountOwnershipsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account, only: [:new, :create, :destroy]
  before_action :set_account_ownership, only: [:destroy]

  def index
    @account_ownerships = AccountOwnership.all
  end

  def new
  end

  def create
    user = User.find_by_email(params[:other_user_email])
    if user.nil?
      flash[:notice] = "Cannot find User with that email address."
    else
      @account_ownership = @account.account_ownerships.new(user: user)
      unless @account_ownership.save
        flash[:notice] = "This lunchbox was not shared with #{user.first_name} #{user.last_name}."
      end
    end
    redirect_to root_path
  end

  def destroy
    user = User.find_by_email(params[:other_user_email])
    @account.account_ownerships.destroy(user: user)
    return unless @account_ownership.destroy
    redirect_to root_path,  warning: "Are you sure you want to remove this account?"
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  def set_account_ownership
    @account_ownership = AccountOwnership.find(params[:id])
  end

  def account_ownership_params
    params.require(:account_ownership).permit(:account_id, :user_id)
  end
end
