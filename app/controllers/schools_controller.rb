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
    @date = params[:date].to_date
    @ordered_items = @school.ordered_items.ordered_between(@date.beginning_of_day,
                                                           @date.end_of_day)
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


end
