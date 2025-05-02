module CurrentCart
  private
    def set_cart
      @cart = Cart.find_by(id: session[:cart_id]) || Cart.find_by(session_id: session.id.to_s)
      return if @cart

      @cart = Cart.create!(session_id: session.id.to_s)
      session[:cart_id] = @cart.id
      Rails.logger.debug "New Cart Created: #{@cart.inspect}"
      
      rescue ActiveRecord::InvalidRecord    
      Rails.logger.debug "Cart creation failed: #{@cart.errors.full_messages}"
    end
end