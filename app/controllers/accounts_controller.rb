class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy, :coverage]

  def new
    if params[:school]
      @school = School.find(params[:school])
      @section_titles = @school.section_titles.split(' ')
    end
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

  def destroy
    return unless @account.destroy
    redirect_to accounts_school_path((School.with_role :admin, current_user).first)
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

  def payment
    @account = Account.find(params[:account])
    @payment = (params[:amount][:payment]).to_i * 100
    @account.balance -= @payment
    @account.save
    redirect_to accounts_school_path(School.find(params[:id]))
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :section, :school_id)
  end

end
