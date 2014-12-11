class SchoolsController < ApplicationController
  before_action :set_school, except: :index

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to action: "show"
    else
      flash[:notice] = 'Please try again.'
    end
  end

  def order
    @date = params[:date].to_date || Date.today
    @sorted_items = @school.report_for @date
    @sorted_for_totals = @sorted_items.shuffle.sort_by { |item| [item.vendor, item.menu_item] }
  end

  def accounts
    @accounts = @school.accounts.sort_by &:section
  end

  def admins
    @admins = User.with_role :admin, @school
  end

  def make_admin
    @user = User.find_by_email(params[:user])
    if @user.nil?
      flash[:notice] = "Cannot find User with that email address."
    else
      @user.add_role :admin, @school
    end
    redirect_to admins_school_path(@school)
  end

  def remove_admin
    @user = User.find_by_email(params[:user])
    if @user.nil?
      flash[:notice] = "There was an error removing that user's Admin rights."
    else
      @user.remove_role :admin, @school
    end
    redirect_to admins_school_path(@school)
  end

  def calendar
    @calendar = set_calendar(@school,params[:begin_date],params[:end_date],params[:style])
    respond_to do |format|
      if @calendar.values.exclude? nil
        format.js { render "shared/calendar", status: :created }
      end
    end
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def set_vendors(school, date)
    @vendors = []
    school.available_menu_items.where(date: date).each do |item|
      @vendors << item.vendor
    end
    @vendors.uniq!
  end

  def school_params
    params.require(:school).permit(:logo, :name, :description, :motto, :address, :phone, :id)
  end

  def set_calendar(school,begin_date = Date.today.beginning_of_month,end_date = Date.today.end_of_month,style = 'simple')
    begin_date = begin_date.to_date
    end_date = end_date.to_date
    events = school.off_days.sort_by{ |day| [day.date] }
    @calendar = { owner: school, events: events, begin_date: begin_date, end_date: end_date, style: style }
  end

end
