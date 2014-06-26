module Tarot
  module Entities
    class MinorArcana < Card
      attr_reader :id, :suit, :rank, :associations

      def initialize(id)
        ensure_valid_input!(id)
        super(:minor)

        @id           = id
        @suit         = build_suit
        @rank         = build_rank
        @associations = build_associations
      end

      private

      def build_suit
        case suit_reference
        when 'w'
          Entities::Wands.new
        when 'p'
          Entities::Pentacles.new
        when 'c'
          Entities::Cups.new
        when 's'
          Entities::Swords.new
        end
      end

      def build_rank
        MINOR_ARCANA[rank_reference].title
      end

      def build_associations
        MINOR_ARCANA[rank_reference].associations
      end

      def suit_reference
        @id.split('_').first
      end

      def rank_reference
        @id.split('_').last
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