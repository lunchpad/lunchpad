class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :calendar]

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

  def calendar
    @calendar = set_calendar(params[:begin_date].to_date,params[:end_date].to_date)
    respond_to do |format|
      if @calendar.values.exclude? nil
        format.js { render "shared/calendar", status: :created }
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
