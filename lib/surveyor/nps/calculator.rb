module Surveyor
  module Nps
    class Calculator
      DETRACTOR          = 0.. 6
      PASSIVE            = 7.. 8
      PROMOTER           = 9..10
      STANDARD_DEVIATION = 0.98

      attr_reader :votes

      def initialize (votes, deviations: 2)
        @votes      = votes
        @deviations = deviations
      end

      def count
        votes.reduce(0, :+)
      end

      def score
        (promoter.percent - detractor.percent)
      end

      def standard_error
        Math.sqrt( (( 1-score)**2)*promoter.percent +
                   (( 0-score)**2)*passive.percent  +
                   ((-1-score)**2)*detractor.percent ) / Math.sqrt(count)
      end

      def confidence_interval
        standard_error * STANDARD_DEVIATION * @deviations
      end

      def high
        (score + confidence_interval)
      end

      def low
        (score - confidence_interval)
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

      def as_hash
        {
          count:               count,
          score:               score,
          high:                high,
          low:                 low,
          standard_error:      standard_error,
          confidence_interval: confidence_interval,
          promoter:            promoter.as_hash,
          passive:             passive.as_hash,
          detractor:           detractor.as_hash
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

        def total_count
          @votes.reduce(0, :+)
        end

        def percent
          (count.to_f / total_count)
        end

        def as_hash
          {
            count:   count,
            percent: percent
          }
        end
      end
    end
  end
end
