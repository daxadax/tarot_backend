require 'open-uri'
require 'csv'

module Tarot
  module Tasks
    class SeedMoonData < Task
      def initialize(year = Time.now.year, feed_data = nil, path = nil)
        @year = year.to_i
        @feed_data = feed_data
        @path = path || "data/lunar_illumination/#{year}.csv"
      end

      def run
        convert_to_csv
      end

      private

      def convert_to_csv
        CSV.open(@path, 'wb', force_quotes: true) do |csv|
          parsed_data.each { |row| csv << row }
        end
      end

      def parsed_data
        @parsed_data ||= parse_feed_data
      end

      def feed_data
        @feed_data ||= fetch_default_feed
      end

      def parse_feed_data
        # http://stackoverflow.com/a/30278554/2128691
        lines = [feed_data.lines[-39]] + feed_data.lines[-37..-7]
        lines.map do |line|
          line.strip!
          [].tap do |pieces|
            pieces << line.slice!(0, 3)   # Day
            line.slice!(0, 4)             # Space
            until line.empty?
              pieces << line.slice!(0, 4) # Month
              line.slice!(0, 5)           # Space
            end
          end.map(&:strip)
        end
      end

      def fetch_default_feed
        open(default_feed_url).read
      end

      def default_feed_url
        host = "http://aa.usno.navy.mil/cgi-bin/aa_moonill2.pl"
        host + "?form=2&year=#{year}&task=00&tz=0&tz_sign=-1"
      end

      def year
        @year
      end
    end
  end
end
