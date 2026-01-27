module Cloudinary
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :require_authentication
    skip_before_action :set_current_cart

    def create
      unless valid_signature?
        Rails.logger.error "\e[101;1mCloudinary webhook signature verification failed\e[0m"
        return head :unauthorized
      end

      handle_notification(params)
      head :ok
    rescue JSON::ParserError => e
      Rails.logger.error "\e[101;1mCloudinary webhook JSON parse error: #{e.message}\e[0m"
      head :bad_request
    end

    private

    def valid_signature?
      signature = request.headers['X-Cld-Signature']
      timestamp = request.headers['X-Cld-Timestamp']

      return false if signature.blank? || timestamp.blank?

      # Cloudinary signature = SHA1(payload + timestamp + api_secret)
      payload = request.raw_post
      api_secret = cloudinary_api_secret
      expected_signature = Digest::SHA1.hexdigest("#{payload}#{timestamp}#{api_secret}")

      ActiveSupport::SecurityUtils.secure_compare(signature, expected_signature)
    end

    # Production keys will be stored in Rails creds in the future for portability.
    # Here: in the absence of a development key in .env, search Rails creds for prod key
    def cloudinary_api_secret
      ENV.fetch('CLOUDINARY_API_SECRET') { Rails.application.credentials.dig(:cloudinary, :api_secret) }
    end

    def handle_notification(params)
      notification_type = params[:notification_type]

      Rails.logger.info "Cloudinary webhook received: #{notification_type}"

      case notification_type
      when 'upload', 'delete', 'resource_tags_changed'
        invalidate_gallery_cache
      else
        Rails.logger.info "Cloudinary webhook unhandled: #{notification_type}"
      end
    end

    def invalidate_gallery_cache
      Rails.cache.delete('gallery_images')
      Rails.logger.info "Gallery cache invalidated via Cloudinary webhook"
    end
  end
end
