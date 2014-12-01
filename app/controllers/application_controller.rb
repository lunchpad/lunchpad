class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # enable_authorization :unless => :devise_controller?

  before_filter :set_time_zone, if: :user_signed_in?

  def cutoff_date
    cutoff_date  = Date.parse('Monday')
    return cutoff_date if cutoff_date > Date.today
    cutoff_date += 7
  end

  private

  def set_time_zone
    Time.zone = current_user.time_zone
  end

end
