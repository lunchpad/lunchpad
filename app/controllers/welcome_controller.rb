class WelcomeController < ApplicationController
  before_action :set_date_range

  def index
    @ordered_items = Account.find(current_user.id).ordered_items.select {|oi| oi["quantity"] > 0 }
  end

  private

  def set_date_range
    @start_date = cutoff_date
    @end_date = @start_date + 4
  end
end

