class WelcomeController < ApplicationController
  before_action :set_date_range

  def index
  end

  private

  def set_date_range
    @start_date = cutoff_date
    @end_date = @start_date + 4
  end
end