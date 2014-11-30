class Order < ActiveRecord::Base
  belongs_to :account
  has_many :ordered_items, dependent: :destroy
  accepts_nested_attributes_for :ordered_items

  validates :account_id,
            presence: true

  def total
    subtotals.sum
  end

  def total_dollars
    Money.new(total).to_s
  end

  def subtotals
    ordered_items.map { |item| item.subtotal }
  end

  def begin_date
    ordered_items.first.date
  end

  def lunch_coverage
    items_ordered = ordered_items.select {|oi| oi["quantity"] > 0 }
    days = items_ordered.map(&:date).uniq
  end

  # def ordered
  #   ordered_items.select {|oi| oi["quantity"] > 0 }
  # end
  #
  # def map_coverage
  #   days = ordered.map(&:date).uniq
  #   days.each do |d|
  #     d.strftime("%A")
  #   end
  # end

end

# <% a = account.has_order_for(@start_date) %>
# <% if a.present? %>
#       <% lc = a.ordered_items.select {|oi| oi["quantity"] > 0 } %>
#   <% days = lc.map(&:date).uniq %>
#       <% days.each do |d| %>
# <%= d.strftime("%A") %>
#         <% end %>
#     <% end %>