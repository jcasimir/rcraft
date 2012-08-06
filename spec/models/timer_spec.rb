require 'spec_helper'

describe Timer do
  let(:timer){ Timer.new(3) }

  context "#ready" do
    it "is not initially true" do
      timer.should_not be_ready
    end

    it "is true after the right number of ticks" do
      3.times{ timer.tick }
      timer.should be_ready
    end

    it "is not true after a wrap-around" do
      4.times{ timer.tick }
      timer.should_not be_ready
    end

    it "is not true after a manual reset" do
      timer.reset
      timer.should_not be_ready
    end
  end
end