class WelcomeController < ApplicationController
  before_action :set_date_range

  def index
    @ordered_items = Account.find(current_user.id).ordered_items.select {|oi| oi["quantity"] > 0 }
  end

  private

  def build_coverage
  #  establish current_user account
  #  look for orders placed for that account
  #  figure out dates associated with those orders
  #  sort by quantity > 0 and then map days out
  end

  def set_date_range
    @start_date = cutoff_date
    @end_date = @start_date + 4
  end
end

