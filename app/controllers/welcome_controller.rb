class WelcomeController < ApplicationController

  def index
    if current_user
      @start_date = cutoff_date - 1
      render 'index'
    else
      render 'sign_in'
    end
  end
end