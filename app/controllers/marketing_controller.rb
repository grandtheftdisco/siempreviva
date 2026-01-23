class MarketingController < ApplicationController
  skip_before_action :require_authentication

  def home
  end

  def gallery
    @images = Rails.cache.fetch('gallery_images', expires_in: 1.hour) do
      Cloudinary::Api.resources_by_tag('gallery', context: true, max_results: 50)['resources']
    end
  rescue Cloudinary::Api::Error => e
    Rails.logger.error "Cloudinary API Error: #{e.message}"
    @images = []
  end

  def learn
  end

  def our_farms
    gallery_images = Rails.cache.fetch('gallery_images', expires_in: 1.hour) do
      Cloudinary::Api.resources_by_tag('gallery', context: true, max_results: 50)['resources']
    end
    @cta_images = gallery_images.sample(3)
  rescue Cloudinary::Api::Error => e
    Rails.logger.error "Cloudinary API Error: #{e.message}"
    @cta_images = []
  end
end
