require 'spec_helper'

class SeedMoonDataSpec < TaskSpec
  let(:year) { nil }
  let(:feed_data) { nil }
  let(:task) { Tasks::SeedMoonData.new(year, feed_data) }

  it 'uses feed data from the US Navy by default' do
    default_feed = task.send :default_feed_url
    assert_includes default_feed, 'navy.mil'
  end

  describe 'with faked feed data' do
    let(:feed_path) { '../../fixtures/fake_moon_feed' }
    let(:fake_feed) { File.expand_path(feed_path, __FILE__) }
    let(:feed_data) { File.read(fake_feed) }
    let(:result) { task.run }

    it 'builds a string in CSV format' do
      rows = result.split("\n")
      columns = rows.first.split(',')
      assert_kind_of String, result
      assert_equal 32, rows.count
      assert_equal 13, columns.count
    end
  end
end
