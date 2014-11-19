class AccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update]


  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.create(account_params)

    return unless @account.save
    redirect_to "/welcome"
  end

  def show
  end

  def edit
  end

  def update
    return unless @account.update(account_params)
    redirect_to @account
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :section, :user_id)
  end

end
