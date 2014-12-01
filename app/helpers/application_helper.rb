module ApplicationHelper

  def calendar_td_options
    ->(start_date, current_calendar_date) {
      {class: "calendar-date", data: {day: current_calendar_date}}
    }
  end

end
