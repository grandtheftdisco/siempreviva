class MarketingController < ApplicationController
  skip_before_action :require_authentication
  def contact
    @contact_form = ContactForm.new
  end

  def home
  end

  def gallery
  end

  def learn
  end

  def our_farms
  end
end
