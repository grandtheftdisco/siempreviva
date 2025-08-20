class UpdateAlgoliaIndexJob < ApplicationJob
  queue_as :default

  def perform
    # 1. retrieve products from Stripe using search API
    products = Stripe::Product.search({query: 'active:"true"'})

    # 2. transform Stripe data to algolia-friendly format
    algolia_records = products.data.map do |product|
      {
        objectId: product.id,
        name: product.name,
        description: product.description
      }
    end

    # 3. push data to algolia
    # Example usage in your job or service
    client = Algolia::SearchClient.create(Rails.application.credentials.algolia[:application_id],
                                          Rails.application.credentials.algolia[:write_api_key])
    client.save_objects("products_index", algolia_records)

    Rails.logger.debug "\e[101;1m----> UpdateAlgoliaIndexJob: #{algolia_records}\e[0"

    algolia_records
    
    # next steps
    # 4. schedule this to run periodically
    # 5. consider implementing webhook listeners for stripe product events to update in real time

    # 6. implement incremental updates: use Stripe's `created` timestamp to only fetch products that have been created or modified since your last sync
  end
end