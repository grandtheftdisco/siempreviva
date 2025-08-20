require "test_helper"

class UpdateAlgoliaIndexJobTest < ActiveJob::TestCase
  test "when job runs, an array of algolia records will be populated" do
    test_records = UpdateAlgoliaIndexJob.perform_now

    puts test_records.inspect
    assert_not_empty(test_records)
  end
end