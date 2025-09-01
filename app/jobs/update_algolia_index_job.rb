class UpdateAlgoliaIndexJob < ApplicationJob
  queue_as :default

  def perform
    products = retrieve_products_from_stripe
    return if products.empty?

    algolia_records = convert_data_for_algolia(products)

    push_data_to_algolia(algolia_records)
  end

  private

  def retrieve_products_from_stripe
    Stripe::Product.search({query: 'active:"true"'})
  end

  def convert_data_for_algolia(products)
    products.data.map do |product|
      {
        objectId: product.id,
        name: product.name,
        description: product.description
      }
    end
  end

  def push_data_to_algolia(algolia_records)
    client = Algolia::SearchClient.create(Rails.application.credentials.algolia[:application_id],
                                          Rails.application.credentials.algolia[:write_api_key])
    client.save_objects("products_index", algolia_records)
    
    algolia_records
  end
end