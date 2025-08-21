require "test_helper"
require "ostruct"

class UpdateAlgoliaIndexJobTest < ActiveJob::TestCase
  test "when job runs, it receives a success response" do
    # prepare fake stripe product data
    fake_products = OpenStruct.new(
      data: [
        OpenStruct.new(id: "prod_123",
                       name: "Test Product",
                       description: "Test Desc")
      ]
    )

    # stub stripe call
    UpdateAlgoliaIndexJob.any_instance.stubs(:retrieve_products_from_stripe)
                                      .returns(fake_products)

    # stub algolia credentials
    application_id = "fake_app_id"
    write_api_key = "fake_api_key"
    Rails.application.credentials
                     .stubs(:algolia)
                     .returns({application_id: application_id,
                               write_api_key: write_api_key })

    # algolia api endpoint for save_objects
    algolia_url = "https://fake_app_id.algolia.net/1/indexes/products_index/batch"

    stub_request(:post, algolia_url)
      .with(body: "{\"requests\":[{\"action\":\"addObject\",\"body\":{\"objectId\":\"prod_123\",\"name\":\"Test Product\",\"description\":\"Test Desc\"}}]}",
            headers: {'Accept'=>'*/*',
                      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                      'Connection'=>'keep-alive',
                      'Content-Type'=>'application/json',
                      'Keep-Alive'=>'30',
                      'User-Agent'=>'Algolia for Ruby (3.23.0); Ruby (3.3.5); Search (3.23.0)',
                      'X-Algolia-Api-Key'=>'fake_api_key',
                      'X-Algolia-Application-Id'=>'fake_app_id'
          })
      .to_return(status: 200, body: "", headers: {})

    UpdateAlgoliaIndexJob.perform_now

    assert_requested :post, algolia_url, times: 1
  end
end