class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # enable_authorization :unless => :devise_controller?


  def cutoff_date
    cutoff_date  = Date.parse('Monday')
    return cutoff_date if cutoff_date > Date.today
    cutoff_date += 7
  end

  def order_week
    begin_date = cutoff_date - 1
    end_date = begin_date + 6
    (begin_date..end_date).to_a
  end
end
