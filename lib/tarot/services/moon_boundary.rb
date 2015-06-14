require 'bound'

module Tarot
  module Services
    class MoonBoundary
      Moon = Bound.required(
        :active_elements,
        :illumination,
        :phase,
        :is_waxing,
        :is_waning
      )

      def at(time)
        moon = fetch_lunar_data(time)
        Moon.new(
          :active_elements => moon.active_elements.map(&:to_sym),
          :illumination => moon.illumination,
          :phase => moon.phase,
          :is_waxing => moon.waxing?,
          :is_waning => moon.waning?
        )
      end
      
      private

      def fetch_lunar_data(time)
        Services::MoonInfo.new(time)
      end


    end
  end
end
