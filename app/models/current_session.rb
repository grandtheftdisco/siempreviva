class CurrentSession
  attr_accessor :id, :cart

  def initialize(id:, cart:)
    @id = id
    @cart = cart
  end
end