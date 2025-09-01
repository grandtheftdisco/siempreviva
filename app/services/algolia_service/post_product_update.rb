module AlgoliaService
  class PostProductUpdate < ApplicationService
    def self.call(product:, previous_attributes:)
      key = previous_attributes.to_hash.keys.first

      old_value = previous_attributes[key]
      new_value = product[key]

      client = ALGOLIA_CLIENT

      res = client.partial_update_object("products_index",
                                         product.id,
                                         {key.to_s => new_value})
    end
  end
end