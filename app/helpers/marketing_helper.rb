module MarketingHelper
  def marketing_image_tag(public_id, **options)
    resource = fetch_cloudinary_resource(public_id)
    alt_text = resource.dig('context', 'custom', 'alt') || public_id.split('/').last.humanize

    cl_image_tag public_id,
      transformation: { width: 800, crop: 'limit', fetch_format: 'auto', quality: 'auto' },
      alt: alt_text,
      class: "marketing-image #{options[:class]}".strip,
      style: options[:style],
      loading: 'lazy'
  end

  private

  def fetch_cloudinary_resource(public_id)
    Rails.cache.fetch("cloudinary_resource/#{public_id}", expires_in: 1.hour) do
      Cloudinary::Api.resource(public_id, context: true)
    end
  rescue Cloudinary::Api::Error => e
    Rails.logger.error "Cloudinary API Error: #{e.message}"
    {}
  end
end
