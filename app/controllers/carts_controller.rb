class CartsController < ApplicationController
  skip_before_action :require_authentication

  def show
    @total = CartService::CalculateCart.call(cart: @cart)
  end

  def update
    respond_to do |format|
      cart_data = cart_params.merge(total_amount: CartService::CalculateCart.call(cart: @cart))

      if @cart.update(cart_data)
        format.html { redirect_to @cart, notice: 'Bag was updated!' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def cart_params
    params.require(:cart).permit
  end
end