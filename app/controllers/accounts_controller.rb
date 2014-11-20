class AccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update]


  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.build(account_params)
    @accounts = current_user.accounts
    @accounts << @account

    if @account.save
      redirect_to root_path, success: 'Account was created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @account.update
      redirect_to root_path, success: 'Account was updated.'
    else
      render :edit
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :section, :user_id)
  end

end
