class OffDaysController < ApplicationController
  before_action :set_school

  def index
    @off_days = @school.off_days.all
    @off_day = @school.off_days.new
  end

  def create
    @dates = params[:off_day][:date].split(", ")
    @name = params[:off_day][:name]
    @dates.each do |date|
      @date = Chronic.parse(date)
      @off_day = @school.off_days.create(name: @name, date: @date)
    end
    redirect_to school_off_days_path
  end

  def destroy
    @off_day = OffDay.find(params[:id])
    return unless @off_day.destroy
    redirect_to school_off_days_path
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def off_day_params
    params.require(:off_day).permit(:name, :date)
  end


end
