class AccountOwnershipsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account_ownership, only: [:destroy]

  def index
    @account_ownerships = AccountOwnership.all
  end

  def new
  end

  def create
    @account_ownership = AccountOwnership.new(account_ownership_params)
    return unless @account_ownership.save
  end

  def destroy
    return unless @account_ownerships.destroy
    redirect_to root_path,  warning: "Are you sure you want to delete this account?"
  end

  private

  def set_account_ownership
    @account_ownerships = AccountOwnership.find(params[:id])
  end

  def account_ownership_params
    params.require(:account_ownership).permit(:account_id, :user_id)
  end
end
