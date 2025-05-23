module ApplicationHelper
  def to_dollars(item_price)
    number_to_currency((item_price / 100).round(2))
  end
end
