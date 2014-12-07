module CalendarHelper
  def calendar_title(begin_date,end_date)
    if month_range?(begin_date,end_date)
      begin_date.strftime('%B %Y')
    else
      title = begin_date.strftime('%b %Y')
      title += ' - ' + end_date.strftime('%b %Y') if begin_date.month != end_date.month
      title
    end
  end

  def calendar_begin_date(begin_date,end_date,forward = true)
    begin_date = begin_date
    end_date = end_date

    if forward
      return begin_date.next_month.beginning_of_month if month_range?(begin_date,end_date)
      begin_date += (end_date - begin_date).to_i + 1
    else
      return begin_date.last_month.beginning_of_month if month_range?(begin_date,end_date)
      begin_date -= (end_date - begin_date).to_i + 1
    end
  end

  def calendar_end_date(begin_date,end_date,forward = true)
    begin_date = begin_date
    end_date = end_date

    if forward
      return end_date.next_month.end_of_month if month_range?(begin_date,end_date)
      end_date += (end_date - begin_date).to_i + 1
    else
      return end_date.last_month.end_of_month if month_range?(begin_date,end_date)
      end_date -= (end_date - begin_date).to_i + 1
    end
  end

  def month_range?(begin_date,end_date)
    begin_date == begin_date.beginning_of_month && end_date == end_date.end_of_month
  end
end