module Surveyor
  module Nps
    class ResultSet < Array
      def initialize (collection)
        map   = collection.map {|a| {a["weight"] => a["count"]} }.reduce({}, :merge)
        array = (0..10).map    {|w| map[w] || 0}
        super(array)
      end
    end
  end
end
