class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :calendar]

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

  def calendar
    @calendar = set_calendar(params[:begin_date].to_date,params[:end_date].to_date)
    respond_to do |format|
      if @calendar.values.exclude? nil
        format.js { render "shared/calendar", status: :created }
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

  def set_calendar(begin_date,end_date)
    begin_date ||= Date.today.beginning_of_month
    end_date ||= Date.today.end_of_month
    @calendar = { owner: @account,
                  events: @account.ordered_items.ordered_between(begin_date.beginning_of_week,end_date.end_of_week),
                  begin_date: begin_date,
                  end_date: end_date,
                  style: params[:style] }
  end
end
