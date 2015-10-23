module Surveyor
  module Nps
    class GroupedReport < Report

      def initialize (responses, group_by:)
        super responses.select("#{group_by} as grouped_by").group("grouped_by")
      end

      def result
        raw_data.group_by{|a| a["grouped_by"]}.map do |group, rows|
          build_result(rows).merge(group: group)
        end
      end

    end
  end
end
