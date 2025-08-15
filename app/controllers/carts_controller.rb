class CartsController < ApplicationController
  skip_before_action :require_authentication
  def show
    @total = CartService::CalculateCart.call(cart: @cart)
  end

  def update
    self.update(total_amount: CartService::CalculateCart.call(cart: self))
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Bag was updated!" }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def cart_params
      params.fetch(:cart, {})
    end
end