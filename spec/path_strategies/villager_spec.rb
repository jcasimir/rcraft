require 'spec_helper'

describe PathStrategy::Villager do
  class DummyBoard
    def coordinates_for(x)
      [0,0]
    end
  end

  class DummyVillager
    include PathStrategy::Villager

    def board
      DummyBoard.new
    end
  end

  let(:villager) { DummyVillager.new }

  before(:each) do
    
  end

  context "#path_to" do
    context "when the path is a straight, unobstructed X-axis line" do
      let(:target){ [3,0] }

      it "returns the correct moves" do
        villager.path_to(target).should == [[1,0], [1,0], [1,0]]
      end
    end

    context "when the path is a straight, unobstructed Y-axis line" do
      let(:target){ [0,3] }

      it "returns the correct moves" do
        villager.path_to(target).should == [[0,1], [0,1], [0,1]]
      end
    end
  end
end