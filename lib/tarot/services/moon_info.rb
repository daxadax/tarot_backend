module Tarot
  module Services
    class MoonInfo < Service

      def initialize(time = nil)
        @time = validate_and_return(time)
      end

      def age
        get_age
      end

      def illumination
        get_illumination
      end

      def phase
        get_phase
      end

      def waxing?
        age < age_when_full
      end

      def waning?
        age > age_when_full
      end

      private

      def current_cycle_progress
        @progress ||= (lunation - lunation.floor).round(2)
      end

      def age_when_full
        14.9
      end

      # this can be much more exact
      def lunation
        # from http://individual.utoronto.ca/kalendis/lunar/#M2L
        @lunation ||= 12.3682665 * (time_delta / mary) - 0.184336
      end

      def get_age
        @age ||= (mean_synodic_period * current_cycle_progress).round(2)
      end

      def get_illumination
        if waxing?
          (age / age_when_full).round(2)
        else
          relative_illumination = (age - age_when_full) / age_when_full
          (1 - relative_illumination).round(2)
        end
      end

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

      def mary # Mean Atomic Revolution Year
        365.2421875
      end

      def mean_synodic_period
        29.5305902778
      end

      def time_delta
        now = time.to_i.to_f / one_day
        now - j2000
      end

      def j2000
        @j2000 ||= Time.utc(2000, 1, 1, 12).to_i.to_f / one_day
      end

      def new?
        age >= 28.5 || age < 1.5
      end

      def crescent?
        age.between?(1.75, 5.75)
      end

      def first_quarter?
        age.between?(5.75, 10.25)
      end

      def gibbous?
        age.between?(10.25, 14)
      end

      def full?
        age.between?(14, 16.5)
      end

      def disseminating?
        age.between?(16.5, 21.25)
      end

      def last_quarter?
        age.between?(21.25, 24.75)
      end

      def balsamic?
        age.between?(24.75, 28.5)
      end

      def one_day
        24 * 3600
      end

      def validate_and_return(time)
        validate_time!(time)
        t = time || Time.now.utc
        Time.utc(t.year, t.month, t.day, t.hour, t.min, t.sec)
      end

      def validate_time!(time)
        return if time.nil?
        raise_utc_error(time) unless time.utc?
        raise_temporal_error(time) unless time.year >= 2000
      end

      def raise_utc_error(time)
        msg = "Time must be UTC #{time.inspect}"
        raise ArgumentError, msg
      end

      def raise_temporal_error(time)
        msg = "Only timestamps after 2000 can be processed"
        raise ArgumentError, msg
      end

      def time
        @time
      end

    end
  end
end
