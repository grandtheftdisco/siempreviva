class ProductsController < ApplicationController
  before_action :call_stripe_products, only: %i[ index show ]
  before_action :set_product, only: %i[ show ]

  def index
  end

  def show
  end

  private
    def call_stripe_products
      @products = Stripe::Product.list(active: true, limit: 100).map do |product|
        ProductWrapper.new(product)
      end
    end
  
    def set_product
      @product = @products.find { |product| product.id == params[:id] }
    end
end
