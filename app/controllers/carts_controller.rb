class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show update ]
  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: "Here's your bag!" }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def update
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
    def set_cart
      @cart = Cart.find(params[:id])
      Rails.logger.debug "Params: #{params.inspect}"
    end

    def cart_params
      params.fetch(:cart, {})
    end
end