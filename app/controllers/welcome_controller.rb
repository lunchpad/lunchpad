class WelcomeController < ApplicationController

  def index
    @start_date = cutoff_date - 1
  end

end