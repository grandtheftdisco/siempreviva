class ProductsController < ApplicationController
  before_action :call_stripe_products, only: %i[ index show ]
  before_action :set_product, only: %i[ show ]
  skip_before_action :require_authentication
  
  def index
  end

  def show
  end

  private
    def call_stripe_products
      @products = Rails.cache.fetch("stripe_products", expires_in: 30.days) do
                    response = Stripe::Product.list(
                      active: true,
                      expand: ['data.default_price']
                    )

                    Rails.logger.info "----------> sending expanded results......"
                    response.data
                  end
    end
  
    def set_product
      @product = @products.find { |product| product.id == params[:id] }
    end
end
