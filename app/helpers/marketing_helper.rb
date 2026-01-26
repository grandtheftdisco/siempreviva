module MarketingHelper
  def cloudinary_alt_text(public_id)
    Rails.cache.fetch("cloudinary_alt_text/#{public_id}", expires_in: 1.hour) do
      resource = Cloudinary::Api.resource(public_id, context: true)
      resource.dig('context', 'custom', 'alt') || public_id.split('/').last.humanize
    end
  rescue Cloudinary::Api::Error => e
    Rails.logger.error "Cloudinary API Error fetching alt text for #{public_id}: #{e.message}"
    public_id.split('/').last.humanize
  end
end
