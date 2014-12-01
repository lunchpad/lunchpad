class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :order]

  def index
    @schools = School.with_role :admin, current_user
  end

  def show
  end

  def order
    @sections = @school.accounts.map { |account| account.section }.uniq
    @date = params[:filter][:date].to_date
    @accounts = @school.accounts
    set_vendors(@school, @date)
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

end
