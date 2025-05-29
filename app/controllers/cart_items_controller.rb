class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ destroy ]

  def create
    cart = Current.cart
    product_setup
    quantity = params[:cart_item][:quantity].to_i

    @new_cart_item = CartService::AddToCart.call(product: @product, 
                                                 cart: cart, 
                                                 quantity: @quantity)

    respond_to do |format|
      format.html { redirect_to cart_path,
        notice: "Item added to bag!" }
      format.json { render :show, 
        status: :created, 
        location: @new_cart_item }
    end
    rescue ActiveRecord::RecordInvalid
      respond_to do |format|    
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @new_cart_item.errors, status: :unprocessable_entity }
      end
  end

  def destroy
    @cart_item.destroy!

    respond_to do |format|
      format.html { redirect_to cart_path, 
                    status: :see_other,
                    notice: "#{@cart_item.name} was removed from your cart."}
      format.json { head :no_content }
    end 
  end

  private
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def product_setup
      @products = Stripe::Product.list(active: true, limit: 100).map do |product|
                    ProductWrapper.new(product)
                  end
      @product = @products.find { |item| item.id == params[:cart_item][:stripe_product_id] }
    end

    def cart_item_params 
      params.require(:cart_item)
        .permit(
          :price, :stripe_product_id, :cart_id, :quantity 
        )
    end
end
