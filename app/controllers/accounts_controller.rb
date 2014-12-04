class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy, :coverage]

  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.build(account_params)
    @accounts = current_user.accounts
    @accounts << @account

    return unless @account.save
    redirect_to root_path, success: 'Account was created.'
  end

  def show
  end

  def edit
  end

  def update
    return unless @account.update(account_params)
    redirect_to root_path, success: 'Account was updated.'
  end

  def coverage
    @order = @account.has_order_for(params[:start_date].to_date + 1)
    @order_week = order_week(params[:start_date].to_date)

    respond_to do |format|
      format.js do
        if @order
          render "shared/coverage", status: :created
        else
          render "shared/coverage", status: :accepted
        end
      end
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :section)
  end
end
