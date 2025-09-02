module StripeService
  class FetchProductInventory < ApplicationService
    def self.call
      Rails.cache.fetch("stripe_products", expires_in: 30.days) do
        response = Stripe::Product.list(
          active: true,
          expand: ['data.default_price']
        )

        response.data
      end
    end
  end
end