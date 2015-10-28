require 'test_helper'
require 'json'

describe Surveyor::Nps::Calculator do
  context "with some votes" do
    Given (:nps) do
      Surveyor::Nps::Calculator.new([10,10,10,10,10,10,10,10,10,10,10])
    end

    Then { nps.count                      ==    110 }
    Then { nps.detractor.count            ==     70 }
    Then { nps.detractor.percent.round(4) == 0.6364 }
    Then { nps.passive.count              ==     20 }
    Then { nps.passive.percent.round(4)   == 0.1818 }
    Then { nps.promoter.count             ==     20 }
    Then { nps.promoter.percent.round(4)  == 0.1818 }

    Then { nps.score.round(4) == -0.4545 }
    Then { nps.high.round(4)  == -0.3084 }
    Then { nps.low.round(4)   == -0.6007 }
  end

  context "with some more votes" do
    Given (:nps) do
      Surveyor::Nps::Calculator.new([18,15,93,44,49,26,68,60,65,16,54])
    end

    Then { nps.count                      ==    508 }
    Then { nps.detractor.count            ==    313 }
    Then { nps.detractor.percent.round(4) == 0.6161 }
    Then { nps.passive.count              ==    125 }
    Then { nps.passive.percent.round(4)   == 0.2461 }
    Then { nps.promoter.count             ==     70 }
    Then { nps.promoter.percent.round(4)  == 0.1378 }

    Then { nps.score.round(4) == -0.4783 }
    Then { nps.high.round(4)  == -0.4153 }
    Then { nps.low.round(4)   == -0.5414 }
  end

  context "with even more votes" do
    Given (:nps) do
      Surveyor::Nps::Calculator.new([6,5,24,43,12,144,156,133,177,1888,44])
    end

    Then { nps.count                      ==   2632 }
    Then { nps.detractor.count            ==    390 }
    Then { nps.detractor.percent.round(4) == 0.1482 }
    Then { nps.passive.count              ==    310 }
    Then { nps.passive.percent.round(4)   == 0.1178 }
    Then { nps.promoter.count             ==   1932 }
    Then { nps.promoter.percent.round(4)  == 0.7340 }

    Then { nps.score.round(4) == 0.5859 }
    Then { nps.high.round(4)  == 0.6139 }
    Then { nps.low.round(4)   == 0.5578 }
  end
end
