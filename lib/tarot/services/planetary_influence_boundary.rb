require 'bound'

module Tarot
  module Services
    class PlanetaryInfluenceBoundary
      PlanetaryInfluence = Bound.required(
        :ruling_signs,
        :ruling_planets,
        :decan_planet,
        :daily_planet,
        :yearly_planet,
        :cyclic_planet
      )

      def at(time)
        data = fetch_planetary_data(time)
        PlanetaryInfluence.new(
          :ruling_signs => data.ruling_signs,
          :ruling_planets => data.ruling_planets,
          :decan_planet => data.decan_planet,
          :daily_planet => data.daily_planet,
          :yearly_planet => data.yearly_planet,
          :cyclic_planet => data.cyclic_planet
        )
      end
      
      private

      def fetch_planetary_data(time)
        Services::PlanetaryInfluence.new(time)
      end


    end
  end
end
