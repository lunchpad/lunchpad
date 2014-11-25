class WelcomeController < ApplicationController
  before_action :set_date_range

  def index
  end

  private

  def set_date_range
    monday  = Date.parse("Monday")
    delta = monday > Date.today ? 0 : 7
    @start_date = (monday + delta)
    @end_date = @start_date + 4
  end
end