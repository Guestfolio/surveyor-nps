module Surveyor
  module Nps
    class Calculator
      DETRACTOR = 0.. 6
      PASSIVE   = 7.. 8
      PROMOTER  = 9..10

      attr_reader :votes

      def initialize (votes)
        @votes = votes
      end

      def count
        votes.reduce(0, :+)
      end

      def score
        promoter.percent - detractor.percent
      end

      def deviation
        Math.sqrt( (( 1-score)**2)*promoter.percent +
                   (( 0-score)**2)*passive.percent  +
                   ((-1-score)**2)*detractor.percent ) / Math.sqrt(count)
      end

      def high
        (score + deviation).round(2)
      end

      def low
        (score - deviation).round(2)
      end

      def detractor
        Cohort.new(DETRACTOR, votes)
      end

      def passive
        Cohort.new(PASSIVE, votes)
      end

      def promoter
        Cohort.new(PROMOTER, votes)
      end

      def to_h
        {
          count:     count,
          score:     score,
          deviation: deviation,
          promoter:  promoter.to_hash,
          passive:   passive.to_hash,
          detractor: detractor.to_hash
        }
      end

      class Cohort
        def initialize (range, votes)
          @votes = votes
          @range = range
        end

        def count
          @votes[@range].reduce(0, :+)
        end

        def percent
          (100.0 * count / @votes.reduce(0, :+)).round(2)
        end

        def to_hash
          {
            count:   count,
            percent: percent
          }
        end
      end
    end
  end
end
