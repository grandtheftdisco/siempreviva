class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[ create ]
  before_action :set_cart_item, only: %i[ update destroy ]

  def new
    @cart_item = CartItem.new
  end

  def create
    Rails.logger.debug "Session Cart ID: #{session[:cart_id]}"
    Rails.logger.debug "Cart: #{@cart.inspect}"
    
    product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.build(product: product)
    @cart_item.cart_id = @cart.id
    @cart_item.price = product.price
    @cart_item.product_id = product.id
    Rails.logger.debug "Cart Item: #{@cart_item.inspect}"
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to show_cart_url(@cart.id),
          notice: "Item added to bag!" }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy
  end

  private
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def cart_item_params 
      params.require(:cart_item)
        .permit(
          :price, :product_id, :cart_id
        )
    end
end
