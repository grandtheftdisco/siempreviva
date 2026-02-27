require "test_helper"
require "ostruct"

class UpdateAlgoliaIndexJobTest < ActiveJob::TestCase
  test "when job runs, it replaces all objects in the algolia index" do
    fake_products = OpenStruct.new(
      data: [
        OpenStruct.new(id: "prod_123",
                       name: "Test Product",
                       description: "Test Desc")
      ]
    )

    expected_records = [
      { objectId: "prod_123", name: "Test Product", description: "Test Desc" }
    ]

    UpdateAlgoliaIndexJob.any_instance.stubs(:retrieve_products_from_stripe)
                                      .returns(fake_products)

    algolia_client = mock("algolia_client")
    algolia_client.expects(:replace_all_objects)
                  .with("products_index", expected_records)
                  .once

    Algolia::SearchClient.stubs(:create).returns(algolia_client)

    UpdateAlgoliaIndexJob.perform_now
  end
end
