module Surveyor
  module Nps
    class Report

      def initialize (responses)
        @responses = responses
      end

      def result
        build_result(raw_data)
      end

      def as_json
        result.to_json
      end

      def group_by (select)
        GroupedReport.new(@responses, group_by: select)
      end

    # protected

      def responses
        @responses
          .joins(:response_set)
          .merge(ResponseSet.completed)
          .joins(:question)
          .merge(Question.net_promoter)
      end

      def query
        table = Answer.table_name
        responses
          .joins(:answer)
          .select("#{table}.weight    as weight")
          .select("COUNT(#{table}.id) as count")
          .group("#{table}.weight")
      end

      def raw_data
        @raw_data ||= query.as_json
      end

      def build_result (data)
        Calculator.new(ResultSet.new(data)).as_hash
      end

    end
  end
end
