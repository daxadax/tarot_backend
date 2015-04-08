module Tarot
  class AssociationFactory

    def build(card)
      CardAssociations.new(card)
    end

    def elemental(element)
      elemental_associations[element]
    end

    private

    def elemental_associations
      {
        :fire => ['masculine', 'instinctual'],
        :earth => ['practical', 'logistical', 'financial', 'transportation'],
        :water => ['feminine', 'emotional', 'cultural', 'social'],
        :air => ['thought patterns', 'education and learning', 'communication']
      }
    end

    class CardAssociations
      attr_reader :general, :golden_dawn

      def initialize(card)
        @card = card
        @general = general
        @golden_dawn = golden_dawn
      end

      def general
        if card.major?
          major_associations[:general][card.id]
        else
          minor_associations[:general][card.rank]
        end
      end

      def golden_dawn
        if card.major?
          major_associations[:golden_dawn][card.id]
        else
          element = card.suit.element
          minor_associations[:golden_dawn][element][card.rank]
        end
      end

      private

      def card
        @card
      end

      def major_associations
        {
          :general => {
            '00' => ['new beginnings', 'spontanaeity', 'ignorance', 'amor fati', 'unorthadox', 'forgotten power'],
            '01' => ['conscious action', 'acting with will', 'concentrated attention', 'creativity'],
            '02' => ['patience', 'discernment', 'balance', 'guidance', 'passive action', 'sub-conscious'],
            '03' => ['point of no return', 'decisiveness'],
            '04' => ['stability'],
            '05' => [
              'academia', 'heritage', 'discipline', 'doing what is expected', 'the Establishment',
              'commitment to a cause', 'dominance/submission', 'roles'
            ],
            '06' => [
              'awareness', 'harmony', 'forming a union', 'physical attraction', 'making a connection',
              'determining what you really care about', 'roles'
            ],
            '07' => ['inner conviction', 'acting alone'],
            '08' => ['recurrence', 'determination', 'purpose'],
            '09' => [
              'instrospection', 'anticipation/anxiety', 'contemplation', 'end of a cycle',
              'offering or seeking guidance', 'quitting old habits', 'withdraw from worldly affairs',
              'acting alone'
            ],
            '10' => ['change', 'transition', 'finality','the end of a cycle', 'new beginnings'],
            '11' => ['awareness'],
            '12' => ['patience', 'passivity'],
            '13' => ['point of no return', 'decisiveness'],
            '14' => ['stability'],
            '15' => ['dominance and submission', 'uncontrolled energy', 'change'],
            '16' => ['awareness', 'departure'],
            '17' => ['acting alone'],
            '18' => ['cycles', 'recurrence', 'focus'],
            '19' => ['acting alone', 'awareness', 'nearing completion'],
            '20' => ['communication', 'cycles'],
            '21' => ['appearances', 'essence', 'roles']
          },
          :golden_dawn => {
            '00' => ['breath of life', 'spirit'],
            '01' => ['attention', 'life and death'],
            '02' => ['memory', 'peace and strife'],
            '03' => ['imagination', 'wisdom and folly'],
            '04' => ['reason', 'sight'],
            '05' => ['intuition', 'hearing'],
            '06' => ['discrimination', 'smell'],
            '07' => ['receptive will', 'speech'],
            '08' => ['suggestion', 'digestion'],
            '09' => ['response and union of opposites', 'touch'],
            '10' => ['rotation', 'wealth and poverty'],
            '11' => ['equilibrium', 'action-work'],
            '12' => ['reversal', 'suspended mind'],
            '13' => ['transformation', 'motion'],
            '14' => [ 'verification', 'wrath'],
            '15' => ['bondage', 'mirth'],
            '16' => ['awakening', 'sin and grace'],
            '17' => ['revelation', 'meditation'],
            '18' => ['organization', 'sleep'],
            '19' => ['regeneration', 'fertility and sterility'],
            '20' => ['realization', 'decision'],
            '21' => ['universal consciousness', 'dominion and slavery']
          }
        }
      end

      def minor_associations
        {
          :general => {
            '01' => ['birth', 'creation', 'a gift', 'a surprise', 'solitude'],
            '02' => ['balance', 'unity', 'duality', 'conflict', 'tension', 'patience', 'relationship', 'instability'],
            '03' => ['social interaction', 'groups', 'decisiveness', 'resolve', 'point of no return'],
            '04' => ['re-evaluation', 'contemplation', 'time to rest and reflect', 'crossroads', 'stability'],
            '05' => ['change', 'loss', 'hard times', 'confusion', 'discord', 'dissonance', 'balance of power', 'dominance and submission'],
            '06' => ['consequences of past action', 'new beginnings', 'departure', 'balance', 'harmony', 'awareness'],
            '07' => ['solitude', 'acting alone', 'inner conviction'],
            '08' => ['recurrence', 'cycles', 'determination', 'focus', 'purpose'],
            '09' => ['solitude', 'isolation', 'anticipation', 'anxiety', 'nearing completion'],
            '10' => ['finality', 'the end of a cycle'],
            '11' => ['instinctual desire', 'routine', 'movement', 'training'],
            '12' => ['physical desire', 'sub-conscious', 'behind-the-scenes', 'drive'],
            '13' => ['emotional desire', 'drawn attention', 'ambition', 'desire', 'pleasure'],
            '14' => ['intellectual desire', 'concentrated attention', 'synthesis', 'supervision', 'consciousness']
          },
          :golden_dawn => {
            :fire => {
              '01' => 'Root of the Powers of Fire',
              '02' => 'Dominion',
              '03' => 'Virtue',
              '04' => 'Completion',
              '05' => 'Strife',
              '06' => 'Victory',
              '07' => 'Valour',
              '08' => 'Swiftness',
              '09' => 'Strength',
              '10' => 'Oppression'
            },
            :earth => {
              '01' => 'Root of the Powers of Earth',
              '02' => 'Change',
              '03' => 'Work',
              '04' => 'Power',
              '05' => 'Worry',
              '06' => 'Success',
              '07' => 'Failure',
              '08' => 'Prudence',
              '09' => 'Gain',
              '10' => 'Wealth'
            },
            :water => {
              '01' => 'Root of the Powers of Water',
              '03' => 'Love',
              '02' => 'Abundance',
              '04' => 'Luxury',
              '05' => 'Dissapointment',
              '06' => 'Pleasure',
              '07' => 'Debauchery',
              '08' => 'Indolence',
              '09' => 'Happiness',
              '10' => 'Satiety'
            },
            :air => {
              '01' => 'Root of the Powers of Air',
              '02' => 'Peace',
              '03' => 'Sorrow',
              '04' => 'Truce',
              '05' => 'Defeat',
              '06' => 'Science',
              '07' => 'Futility',
              '08' => 'Interference',
              '09' => 'Cruelty',
              '10' => 'Ruin'
            }
          }
        }
      end

    end
  end
end
