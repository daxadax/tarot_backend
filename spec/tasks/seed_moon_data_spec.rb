require 'spec_helper'

class SeedMoonDataSpec < TaskSpec
  let(:year) { nil }
  let(:feed_data) { nil }
  let(:path) { 'spec/fake_moon_phase.csv' }
  let(:task) { Tasks::SeedMoonData.new(year, feed_data, path) }

  it 'uses feed data from the US Navy by default' do
    default_feed = task.send :default_feed_url
    assert_includes default_feed, 'navy.mil'
  end

  describe 'with faked feed data' do
    after { File.delete(path) }

    let(:feed_path) { '../../fixtures/fake_moon_feed' }
    let(:fake_feed) { File.expand_path(feed_path, __FILE__) }
    let(:feed_data) { File.read(fake_feed) }
    let(:result) { CSV.read(path) }

    it 'builds a string in CSV format' do
      task.run
      rows = result.count
      columns = result.first.count
      assert_equal 32, rows
      assert_equal 13, columns
    end
  end
end
