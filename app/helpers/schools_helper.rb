module SchoolsHelper

  def quantity_of(menu_item)
    sum = []
    menu_item.ordered_items.find_each do |ordered|
      unless ordered.quantity < 1
        sum << ordered.quantity
      end
    end
    sum.map(&:to_i).reduce(:+)
  end

end
