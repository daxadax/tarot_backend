module Tarot
  module Entities
    class MajorArcana < Card
      attr_reader :title, :id

      def initialize(id)
        ensure_valid_input!(id)
        super(:major)

        @title  = titles[id]
        @id     = id
      end

      private

      def ensure_valid_input!(id)
        ensure_required_input!(:id, id, {:type => Integer})
        ensure_valid_id!(id)
      end

      def ensure_valid_id!(id)
        unless valid_ids.include?(id)
          reason = "Only #{valid_ids.join(', ')} are valid Major Arcana IDs"
          raise_argument_error reason, id
        end
      end

      def titles
        {
          0 => 'The Fool',
          1 => 'The Magician',
          2 => 'The High Priestess',
          3 => 'The Empress',
          4 => 'The Emperor',
          5 => 'The Hierophant',
          6 => 'The Lovers',
          7 => 'The Chariot',
          8 => 'Strength',
          9 => 'The Hermit',
          10 => 'The Wheel',
          11 => 'Justice',
          12 => 'The Hanged Man',
          13 => 'Death',
          14 => 'Temperance',
          15 => 'The Devil',
          16 => 'The Tower',
          17 => 'The Star',
          18 => 'The Moon',
          19 => 'The Sun',
          20 => 'Judgement',
          21 => 'The World'
        }
      end

      def valid_ids
        (0..21).to_a
      end

    end
  end
end
