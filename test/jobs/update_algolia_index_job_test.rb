require "test_helper"

class UpdateAlgoliaIndexJobTest < ActiveJob::TestCase
  # FIXME - right now this test is broken because of how I'm trying to restructure the job
  test "when job runs, an array of algolia records will be populated" do
    test_records = UpdateAlgoliaIndexJob.perform_now

    puts test_records
    assert_not_empty(test_records)
  end
end