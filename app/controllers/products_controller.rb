class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]
  def index
    # implement a bg job to migrate these periodically
    @products = Stripe::Product.list(active: true, limit: 100).map do |product|
                  ProductWrapper.new(product)
                end
  end

  def show
  end

  private
    def set_product
      @product = Product.find(params.expect(:id))
    end
end
