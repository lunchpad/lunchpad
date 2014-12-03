class SchoolsController < ApplicationController
  before_action :set_school, except: :index

  def index
    @schools = School.with_role :admin, current_user
    if @schools.count == 1
      redirect_to school_path(@schools.first)
    end
  end

  def show
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

  def update
    @school.update(school_params)

  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(:name, :description, :motto, :phone, :address)
  end

  def set_vendors(school, date)
    @vendors = []
    school.available_menu_items.where(date: date).each do |item|
      @vendors << item.vendor
    end
    @vendors.uniq!
  end

end
