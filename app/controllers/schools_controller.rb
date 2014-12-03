class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :order, :accounts]

  def index
    @schools = School.with_role :admin, current_user
    if @schools.count == 1
      redirect_to school_path(@schools.first)
    end
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)

    if @school.save
      redirect_to action: "index", success: 'School was created.'
    else
      render :new, alert: "Please try again."
    end
  end

  def show

  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to action: "index", success: 'School profile was updated.'
    else
      render :edit, alert: "Please try again."
    end
  end

  def order
    @sections = @school.accounts.map { |account| account.section }.uniq.sort
    @date = params[:filter][:date].to_date
    @accounts = @school.accounts
    set_vendors(@school, @date)
  end

  def accounts
    @accounts = @school.accounts.sort_by &:section
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

  def create
    @user = User.create( user_params )
  end

  def school_params
    params.require(:school).permit(:logo)
  end


end
