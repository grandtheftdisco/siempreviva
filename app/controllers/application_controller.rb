class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_cart
  before_action :set_current_session

  private
  
  def set_cart
    @cart = Cart.find_or_create_by(session_id: session.id.to_s)
  end

  def set_current_session
    session_id = session[:session_id]
    cart = Cart.find_or_create_by(session_id: session_id)

    Current.session = CurrentSession.new(
      id: session_id,
      cart: cart
    )
    Rails.logger.debug "Current session: #{Current.session.inspect}"
  end
end
