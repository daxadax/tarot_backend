module Tarot
  module Services
    class PlanetaryInfluence < Service
      Influences = Bound.new(
        :ruling_signs,
        :ruling_planets,
        :decan_planet,
        :daily_planet,
        :yearly_planet,
        :cyclic_planet
      )
      
      def initialize(time_of_reading = nil)
        @time_of_reading = validate!(time_of_reading)
        @ruling_signs = []
      end

      def calculate
        Influences.new determine_influences 
      end

      private

      def determine_influences
        {
          :ruling_signs => ruling_signs,
          :ruling_planets => ruling_planets,
          :decan_planet => decan_planet,
          :daily_planet => daily_planet,
          :yearly_planet => yearly_planet,
          :cyclic_planet => cyclic_planet
        }
      end

      def ruling_signs
        determine_ruling_signs if @ruling_signs.empty?
        @ruling_signs
      end

      def ruling_planets
        ruling_signs.map do |sign|
          ruling_planet_lookup[sign]
        end
      end

      def decan_planet
        decan_planet_lookup.detect do |planet, active_days|
          return planet if active_days.include?(yday)
        end
        # 21..30 a1 21jan -30 saturn
        # 31..40 a2 31j - 9 feb mercury
        # 41..50 a3 10-19feb venus

        # 51..60 p1 20-29 feb jupiter
        # 61..69 p2 1-10 mar moon
        # 70..79 p3 11-20 mar mars

        # 80..89 a1 21-30 mar mars
        # 90..99 a2 31 mar - 9 apr sun
        # 100..109 a3 10-19 apr jupiter

        # 110..119 t1 20-29 apr venus
        # 120..129 t2 30 apr - 9 may mercury
        # 130..139 t3 10-19 may saturn

        # 140..149 g1 20-29 may mercury
        # 150..159 g2 30 may - 8 june venus
        # *160..171 g3 9-20 june saturn

        # *172..183 c1 21 jun - 2 jul moon
        # 184..193 c2 3-12 jul mars
        # 194..203 c3 13-22 jul jupiter

        # 204..213 l1 23 jul - 1 aug sun
        # 214..223 l2 2-11 aug jupiter
        # 224..233 l3 12-21 aug mars

        # 234..243 v1 22-31 aug mercury
        # 244..253 v2 1-10 sep saturn
        # *254..265 v3 11-22 sep  venus

        # 266..275 l1 23 sep - 2 oct venus
        # 276..285 l2 3 -12 oct saturn
        # 286..295 l3 13-22 oct mercury

        # *296..304 s1 23-31 oct mars
        # 305..314 s2 1-10 nov jupiter
        # *315..325 s3 11-21 nov moon

        # 326..335 s1 22 nov - 1 dec jupiter
        # 336..345 s2 2-11 dec mars
        # 346..355 s3 12-21 dec sun

        # 356..366 || 1 c1 22 dec - 1 jan saturn
        # 1..10 c2 1 - 10 jan venus
        # 11..20 c3 11-20 jan mercury
      end

      def daily_planet
        return :sun if time_of_reading.sunday?
        return :moon if time_of_reading.monday?
        return :mars if time_of_reading.tuesday?
        return :mercury if time_of_reading.wednesday? 
        return :jupiter if time_of_reading.thursday?
        return :venus if time_of_reading.friday? 
        return :saturn if time_of_reading.saturday? 
      end

      def yearly_planet
        inner_cycle = current_cycle_progress % 7
        current_cycle_index = current_cycle_number - 1
        yearly_rotation.rotate(current_cycle_index)[inner_cycle]
      end

      def cyclic_planet
        cyclic_rotation[current_cycle_number]
      end

      def current_cycle_number
        (time_since_known_cycle / cycle_length).floor
      end

      def current_cycle_progress
        (time_since_known_cycle / cycle_length) % 1 * cycle_length 
      end

      def cycle_length
        36.0 # years
      end

      def time_since_known_cycle
        # martian cycle started on 21 March, 1909
        (time_of_reading - Time.utc(1909, 3, 21)) / (60 * 60 * 24 * mary)
      end

      def mary # Mean Atomic Revolution Year
        365.2421875
      end

      def cyclic_rotation
        %i[mars moon sun saturn venus jupiter mercury]
      end

      def yearly_rotation
        #starts with first planet of current cycle, then loops in this order:
        #sun venus mercury moon saturn jupiter mars
        %i[mars sun venus mercury moon saturn jupiter]
      end

      def determine_ruling_signs
        add_sign :aquarius    if yday.between?(19, 57)    # 19 jan - 26 feb
        add_sign :pisces      if yday.between?(49, 86)    # 18 feb - 27 mar
        add_sign :aries       if yday.between?(79, 116)   # 20 mar - 26 apr
        add_sign :taurus      if yday.between?(109, 146)  # 19 apr - 26 may
        add_sign :gemini      if yday.between?(139, 178)  # 19 may - 27 jun 
        add_sign :cancer      if yday.between?(171, 210)  # 20 jun - 29 jul
        add_sign :leo         if yday.between?(203, 240)  # 22 jul - 28 aug
        add_sign :virgo       if yday.between?(233, 272)  # 21 aug - 29 sep
        add_sign :libra       if yday.between?(264, 302)  # 21 sep - 29 oct
        add_sign :scorpio     if yday.between?(294, 332)  # 21 oct - 28 nov
        add_sign :sagittarius if yday.between?(324, 362)  # 20 nov - 28 dec
        add_sign :capricorn   if yday > 353 || yday < 26  # 20 dec - 26 jan
      end

      def add_sign(sign)
        @ruling_signs.push(sign)
      end

      def ruling_planet_lookup
        {
          :aquarius => :saturn,
          :pisces => :jupiter,
          :aries => :mars,
          :taurus => :venus,
          :gemini => :mercury,
          :cancer => :moon,
          :leo => :sun,
          :virgo => :mercury,
          :libra => :venus,
          :scorpio => :mars,
          :sagittarius => :jupiter,
          :capricorn => :saturn
        }
      end

      def decan_planet_lookup
        {
          :mars => [*70..89, *184..193, *224..233, *296..304, *336..345],
          :moon => [*61..69, *172..183, *315..325],
          :sun => [*90..99, *204..213, *346..355],
          :saturn => [*21..30, *130..139, *160..171, *244..253, *276..285, *356..366],
          :venus => [*1..10, *41..50, *110..119, *150..159, *254..275],
          :jupiter => [*51..60, *100..109, *194..203, *214..223, *305..314, *326..335],
          :mercury => [*11..20, *31..40, *120..129, *140..149, *234..243, *286..295]
        }
      end

      def validate!(time)
        return Time.now.utc if time.nil?
        return time if time.utc?
        raise ArgumentError, "Time must be given as UTC" 
      end

      def yday
        @yday ||= calculate_yday 
      end

      def calculate_yday
        yday = time_of_reading.yday
        return yday unless time_of_reading.to_date.leap?
        return yday unless yday > 59 
        yday - 1
      end

      def time_of_reading
        @time_of_reading
      end
    end
  end
end
