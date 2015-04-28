module Tarot
  module Entities
    class MinorArcana < Card
      attr_reader :id, :suit, :rank, :associations

      def self.build_all
        %w[w p c s].flat_map do |suit|
          rank_mapping.keys.map do |id|
            self.new("#{suit}_#{id}")
          end
        end
      end

      def initialize(id)
        ensure_valid_input!(id)
        super(:minor)

        @id = id
        @suit = build_suit
        @rank = rank_reference
        @associations = association_factory.build(self)
      end

      def display_name
        "#{named_rank.capitalize} of #{suit.name}"
      end

      def court?
        return true if court_cards.include?(self.rank)
        false
      end

      private

      def court_cards
        %w[11 12 13 14]
      end

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

      def named_rank
        self.class.rank_mapping[rank_reference]
      end

      def suit_reference
        @suit_reference ||= id.split('_').first
      end

      def rank_reference
        @rank_reference ||= id.split('_').last
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
        unless suits.include?(suit_id)
          reason = "Only #{suits.join(', ')} are valid suit ids}"
          raise_argument_error reason, suit_id
        end
      end

      def ensure_valid_rank!(rank_id)
        unless valid_ranks.include?(rank_id)
          reason = "Only #{valid_ranks.join(', ')} are valid rank ids}"
          raise_argument_error reason, rank_id
        end
      end

      def valid_ranks
        self.class.rank_mapping.keys
      end

      def self.rank_mapping
        {
          '01' => :ace,
          '02' => :two,
          '03' => :three,
          '04' => :four,
          '05' => :five,
          '06' => :six,
          '07' => :seven,
          '08' => :eight,
          '09' => :nine,
          '10' => :ten,
          '11' => :page,
          '12' => :knight,
          '13' => :queen,
          '14' => :king
        }
      end

    end
  end
end
