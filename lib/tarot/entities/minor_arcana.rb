module Tarot
  module Entities
    class MinorArcana < Card
      attr_reader :id, :suit, :rank

      def initialize(id)
        ensure_valid_input!(id)
        super(:minor)

        @id   = id
        @suit = build_suit
        @rank = build_rank
      end

      private

      def build_suit
        case deserialized_id.first
        when 'w'
          Entities::Wand.new
        when 'p'
          Entities::Pentacle.new
        when 'c'
          Entities::Cup.new
        when 's'
          Entities::Sword.new
        end
      end

      def build_rank
        rank_id = deserialized_id.last

        MINOR_ARCANA[rank_id]
      end

      def deserialized_id
        @id.split('_')
      end

      def ensure_valid_input!(id)
        ensure_required_input!(:id, id)
        ensure_valid_id!(id)
      end

      def ensure_valid_id!(id)
        split_id = id.split('_')

        ensure_valid_suit!(split_id.first)
        ensure_valid_rank!(split_id.last)
      end

      def ensure_valid_suit!(suit_id)
        unless valid_suits.include?(suit_id)
          reason = "Only #{valid_suits.join(', ')} are valid suit ids}"
          raise_argument_error reason, suit_id
        end
      end

      def ensure_valid_rank!(rank_id)
        unless valid_ranks.include?(rank_id)
          reason = "Only #{valid_ranks.join(', ')} are valid rank ids}"
          raise_argument_error reason, rank_id
        end
      end

      def valid_suits
        %w[w p c s]
      end

      def valid_ranks
        MINOR_ARCANA.keys
      end

    end
  end
end