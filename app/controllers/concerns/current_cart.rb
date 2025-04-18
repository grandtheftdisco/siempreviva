module CurrentCart
  private
    def set_cart
      Rails.logger.debug "Session Cart ID before set_cart: #{session[:cart_id]}"
      @cart = Cart.find_by(id: session[:cart_id]) || Cart.find_by(session_id: session.id.to_s)
      if @cart.nil?
        @cart = Cart.create(session_id: session.id.to_s)
        if @cart.persisted?
          session[:cart_id] = @cart.id
          Rails.logger.debug "New Cart Created: #{@cart.inspect}"
        else
          Rails.logger.debug "Cart creation failed: #{@cart.errors.full_messages}"
        end
      end
      Rails.logger.debug "Cart after set_cart: #{@cart.inspect}"
    end
end