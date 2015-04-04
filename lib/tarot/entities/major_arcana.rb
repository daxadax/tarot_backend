module Tarot
  module Entities
    class MajorArcana < Card
      attr_reader :title, :element, :domain, :associations, :id

      def self.build_all
        title_mapping.keys.flat_map do |id|
          self.new(id)
        end
      end

      def initialize(id)
        ensure_valid_input!(id)
        super(:major)

        @id = id
        @title = self.class.title_mapping[id]
        @element = determine_element(id)
        @domain = association_factory.elemental(element)
        @associations = association_factory.general(:major, id)
      end

      def display_name
        @title
      end

      private

      def determine_element(id)
        return :fire if %w[04 08 10 14 16 19 20].include? id
        return :earth if %w[03 05 09 15 21].include? id
        return :water if %w[02 07 12 13 18].include? id
        return :air if %w[00 01 06 11 17 ].include? id
      end

      def ensure_valid_input!(id)
        ensure_required_input!(:id, id)
        ensure_valid_id!(id)
      end

      def ensure_valid_id!(id)
        unless valid_ids.include?(id)
          reason = "Only #{valid_ids.join(', ')} are valid Major Arcana IDs"
          raise_argument_error reason, id
        end
      end

      def valid_ids
        self.class.title_mapping.keys
      end

      def self.title_mapping
        {
          '00' => 'The Fool',
          '01' => 'The Magician',
          '02' => 'The High Priestess',
          '03' => 'The Empress',
          '04' => 'The Emperor',
          '05' => 'The Hierophant',
          '06' => 'The Lovers',
          '07' => 'The Chariot',
          '08' => 'Strength',
          '09' => 'The Hermit',
          '10' => 'The Wheel',
          '11' => 'Justice',
          '12' => 'The Hanged Man',
          '13' => 'Death',
          '14' =>  'Temperance',
          '15' => 'The Devil',
          '16' => 'The Tower',
          '17' =>  'The Star',
          '18' => 'The Moon',
          '19' => 'The Sun',
          '20' => 'Judgement',
          '21' => 'The World'
        }
      end

    end
  end
end
