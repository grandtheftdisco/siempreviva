class ProductsController < ApplicationController
  skip_before_action :require_authentication
  before_action :call_stripe_products, only: %i[index show]
  before_action :set_product, only: %i[show]

  def index
  end

  def show
    # Get 3 random products for cross-sells, excluding current product
    @cross_sell_products = @products.reject { |p| p.id == @product.id }.sample(3)
  end

  private
    def call_stripe_products
      @products = StripeService::FetchProductInventory.call
    end
  
    def set_product
      @product = @products.find { |product| product.id == params[:id] }
    end
end
