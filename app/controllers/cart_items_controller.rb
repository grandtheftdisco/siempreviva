class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ update destroy ]

  def new
    @cart_item = CartItem.new
  end

  def create
    @cart = Current.cart
    @product = Product.find(params[:product_id])
    @new_cart_item = CartService::AddToCart.call(product: @product, cart: @cart)
    respond_to do |format|
      if @new_cart_item.save
        format.html { redirect_to cart_path(@cart.id),
          notice: "Item added to bag!" }
        format.json { render :show, status: :created, location: @new_cart_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @new_cart_item.errors, status: :unprocessable_entity }
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
