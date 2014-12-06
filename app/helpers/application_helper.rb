module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


  def find_ordered_items_for(account, start_date, end_date)
    begin_datetime = start_date.beginning_of_day
    end_datetime = end_date.end_of_day
    OrderedItem.joins(:order, :available_menu_item).where('account_id = ? AND quantity > ? AND date > ? AND date < ?',account.id,0,begin_datetime,end_datetime)
  end


end