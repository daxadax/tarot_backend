require 'open-uri'
require 'csv'

class SeedMoonData < Task
  # filename = "#{year}_lunar_illumination.csv"

  def initialize(year = Time.now.year, feed_data = nil)
    @year = year.to_i
    @feed_data = feed_data || fetch_feed_data
  end

  def seed
    convert_to_csv
  end

  private

  def convert_to_csv
    CSV.generate(force_quotes: true) do |csv|
      feed_data.each { |row| csv << row }
    end
  end

  def parsed_data
    @parsed_data ||= parse_feed_data
  end

  def feed_data
    @feed_data
  end

  def parse_feed_data
    # http://stackoverflow.com/a/30278554/2128691
    lines = [data.lines[-39]] + data.lines[-37..-7]
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

  def fetch_feed_data
    open(feed_uri).read
  end

  def default_feed_uri
    host = "http://aa.usno.navy.mil/cgi-bin/aa_moonill2.pl"
    host + "?form=2&year=#{year}&task=00&tz=0&tz_sign=-1"
  end

  def year
    @year
  end
end
