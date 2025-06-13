class Order < ApplicationRecord
  self.filter_attributes += [ :customer_email_address ]
end