class WelcomeController < ApplicationController
  before_action :set_date_range

  def index
    if current_user
      @order_week = order_week
      render 'index'
    else
      render 'sign_in'
    end
  end

  private

  def set_date_range
    @start_date = cutoff_date
    @end_date = @start_date + 4
  end
end

