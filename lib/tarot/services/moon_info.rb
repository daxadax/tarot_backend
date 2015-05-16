module Tarot
  module Services
    class MoonInfo < Service

      def initialize(time = nil)
        @current_time = validate_and_return(time)
        @lunar_data = fetch_data
      end

      def illumination
        @illumination ||= @lunar_data[day][month].to_f
      end

      def phase
        get_phase
      end

      def waxing?
        return true if @lunar_data[day - 1][month].to_f < illumination  
        false
      end

      def waning?
        return true unless waxing?
        false
      end

      private

      def get_phase
        return :new if new?
        return :crescent if crescent?
        return :first_quarter if first_quarter?
        return :gibbous if gibbous?
        return :full if full?
        return :disseminating if disseminating?
        return :last_quarter if last_quarter?
        return :balsamic if balsamic?
      end

      def new?
        return true if illumination.between?(0, 0.12)
      end

      def crescent?
        return true if waxing? && illumination.between?(0.12, 0.37)
      end

      def first_quarter?
        return true if waxing? && illumination.between?(0.37, 0.62)
      end

      def gibbous?
        return true if waxing? && illumination.between?(0.62, 0.87)
      end

      def full?
        return true if illumination.between?(0.87, 1)
      end

      def disseminating?
        return true if waning? && illumination.between?(0.62, 0.87)
      end

      def last_quarter?
        return true if waning? && illumination.between?(0.37, 0.62)
      end

      def balsamic?
        return true if waning? && illumination.between?(0.12, 0.37)
      end

      def validate_and_return(time)
        validate_time!(time)
        t = time || Time.now.utc
        Time.utc(t.year, t.month, t.day, t.hour, t.min, t.sec)
      end

      def validate_time!(time)
        return if time.nil?
        raise_utc_error(time) unless time.utc?
      end

      def raise_utc_error(time)
        msg = "Time must be UTC #{time.inspect}"
        raise ArgumentError, msg
      end

      def fetch_data
        relative = "../../../../data/lunar_illumination/#{year}.csv" 
        file = File.expand_path(relative, __FILE__)
        CSV.read(file)
      end

      def year
        @current_time.year
      end

      def month
        @current_time.month
      end

      def day
        @current_time.day
      end
    end
  end
end
