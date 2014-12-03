class WelcomeController < ApplicationController
  before_action :set_date_range

  def index
  end

  private

  def set_date_range
    @start_date = cutoff_date
    @end_date = @start_date + 4
    params[:start_date] = (cutoff_date - 1).to_date
  end
end