class CartItemsController < ApplicationController
  skip_before_action :require_authentication
  before_action :set_cart_item, only: %i[update destroy]

  def create
    product_setup
    quantity = params[:cart_item][:quantity].to_i

    @new_cart_item = CartService::AddToCart.call(
      product: @product,
      cart: @cart,
      quantity: quantity
    )
    @cart.update(total_amount: CartService::CalculateCart.call(cart: @cart))

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Item added to bag!' }
      format.json { render :show, status: :created, location: @new_cart_item }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html do
        redirect_to cart_path, alert: 'Could not add item to cart. Please try again later.'
      end
      format.json { render json: @new_cart_item.errors, status: :unprocessable_entity }
    end
  rescue Stripe::StripeError
    respond_to do |format|
      format.html do
        redirect_to products_path, alert: 'Unable to add item to cart. Please try again later.'
      end
      format.json { render json: { error: 'Stripe error' }, status: :unprocessable_entity }
    end
  rescue StandardError => e
    respond_to do |format|
      format.html do
        redirect_to products_path, alert: 'An error occurred. Please try again later.'
      end
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @cart_item.update!(cart_item_params)
      @cart.update!(total_amount: CartService::CalculateCart.call(cart: @cart))
    end

    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Quantity updated!' }
      format.json { render :show, status: :ok, location: @cart_item }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html do
        redirect_to cart_path, alert: 'Could not update quantity. Please try again.'
      end
      format.json { render json: @cart_item.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @cart_item.destroy!
    @cart.update(total_amount: CartService::CalculateCart.call(cart: @cart))

    respond_to do |format|
      format.html do
        redirect_to cart_path,
                    status: :see_other,
                    notice: "#{@cart_item.name} was removed from your cart."
      end
      format.json { head :no_content }
    end
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

    def product_setup
      @products = StripeService::FetchProductInventory.call
      @product = @products.find { |item| item.id == params[:cart_item][:stripe_product_id] }
    end

  def cart_item_params
    params.require(:cart_item)
          .permit(:price, :stripe_product_id, :cart_id, :quantity)
  end
end
