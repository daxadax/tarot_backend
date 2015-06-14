module Tarot
  module Services
    class MoonInfo < Service

      def initialize(time = nil)
        @current_time = validate_and_return(time)
        @lunar_data = fetch_data
        @active_elements = []
      end

      def illumination
        @illumination ||= @lunar_data[day][month].to_f
      end

      def phase
        get_phase
      end

      def active_elements
        get_active_elements
      end

      def waxing?
        return false if terminal?
        return true if growing? 
        false
      end

      def waning?
        return false if terminal?
        return true unless growing?
        false
      end

      private

      def terminal?
        full? || new?
      end

      def growing?
        @lunar_data[day - 1][month].to_f < illumination  
      end

      def get_phase
        return :new if new?
        return :full if full?
        if waxing? 
          return :crescent if small?
          return :first_quarter if medium?
          return :gibbous if large?
        else 
          return :disseminating if large?
          return :last_quarter if medium?
          return :balsamic if small?
        end
      end

      def get_active_elements
        add_element('earth') if small?
        add_element('fire') if large?
        add_element('air') if waxing?
        add_element('water') if waning?
        @active_elements
      end

      def new?
        return true if illumination == 0
      end
      
      def full?
        return true if illumination == 1
      end

      def small?
        illumination.between?(0.00, 0.33)
      end

      def medium?
        illumination.between?(0.34, 0.66)
      end

      def large?
        illumination.between?(0.67, 1)
      end
     
      def add_element(element)
        @active_elements << element
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
