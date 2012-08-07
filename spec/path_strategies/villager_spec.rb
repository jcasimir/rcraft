require 'spec_helper'

describe PathStrategy::Villager do
  class DummyVillager; end

  class DummyBoard
    def coordinates_for(x)
      [0,0]
    end
  end

  let(:villager) { DummyVillager.new }
  let(:board) { DummyBoard.new }
  let(:strategy){ PathStrategy::Villager.new(villager, target, board)}

  context "#path" do
    context "when the path is a straight, unobstructed X-axis line" do
      let(:target){ [3,0] }

      it "returns the correct moves" do
        strategy.path.should == [[1,0], [1,0], [1,0]]
      end
    end

    context "when the path is a straight, unobstructed Y-axis line" do
      let(:target){ [0,3] }

      it "returns the correct moves" do
        strategy.path.should == [[0,1], [0,1], [0,1]]
      end
    end
  end

  context "#empty?" do
    let(:target){ [0,0] }

    it "is true when the path is complete" do
      strategy.path.should be_empty
    end
  end
end