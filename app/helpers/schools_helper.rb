module SchoolsHelper

  def sum_of(available_id)
    sum = []
    OrderedItem.where(available_menu_item_id: available_id).each do |item|
      unless item.quantity < 1
        sum << item.quantity
      end
    end
    sum.map(&:to_i).reduce(:+)
  end

end
