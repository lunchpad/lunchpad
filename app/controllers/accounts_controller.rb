class AccountsController < ApplicationController
  include CalendarHelper
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :calendar]

  def index
      @accounts = current_user.accounts.order('name ASC')
      @calendars = Hash[current_user.accounts.map { |account| [account.id, set_calendar(account)] }]
      @start_date = cutoff_date - 1
  end

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
    @calendar = set_calendar(@account,params[:begin_date],params[:end_date],params[:style])
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

  def set_calendar(account,begin_date = Date.today.beginning_of_month,end_date = Date.today.end_of_month,style = 'simple')
    begin_date = begin_date.to_date
    end_date = end_date.to_date
    events = account.ordered_items.ordered_between(begin_date.beginning_of_week,end_date.end_of_week)
    events = events.sort_by{ |item| [item.available_menu_item.date, item.order.account.name, item.menu_item.name] }
    @calendar = { owner: account, events: events, begin_date: begin_date, end_date: end_date, style: style }
  end
end
