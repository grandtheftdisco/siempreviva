module ApplicationHelper
  def to_dollars(item_price)
    number_to_currency((item_price / 100).round(2))
  end

  def format_time(timestamp)
    timestamp.strftime('%m/%d/%Y, %I:%M%P (%Z)')
  end
end
