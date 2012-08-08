require 'spec_helper'

describe PathStrategy::Villager do
  class DummyUnwalkable
    def walkable?; false; end
  end

  class DummyWalkable
    def walkable?; true; end
  end

  class DummyBoard
    def initialize(coords = [0,0])
      @coords = coords
    end

    def coordinates_for(x)
      @coords
    end

    def terrain_at(coordinates)
      if (coordinates.first > 20) || (coordinates.first > 10 && coordinates.first.even?)
        DummyUnwalkable.new
      else
        DummyWalkable.new
      end
    end

    def blocked?(coords)
      !terrain_at(coords).walkable?
    end
  end

  class DummyVillager
    include PathStrategy::Villager

    def initialize(board = DummyBoard.new)
      @board = board
    end

    def board
      @board
    end
  end

  let(:villager) { DummyVillager.new }

  before(:each) do
    
  end

  context "#path_to" do
    context "when the path is a straight, unobstructed X-axis line" do
      let(:target){ [3,0] }

      it "returns the correct moves" do
        villager.path_to(target).should == [[1,0], [2,0], [3,0]]
      end
    end

    context "when the path is a straight, unobstructed Y-axis line" do
      let(:target){ [0,3] }

      it "returns the correct moves" do
        villager.path_to(target).should == [[0,1], [0,2], [0,3]]
      end
    end
  end

  context "#traversable_from" do
    let(:villager){ DummyVillager.new(DummyBoard.new([2,2]))}
    context "all land" do
      it "returns all 8 tiles" do
        villager.traversable_from([2,2]).sort.should == 
            [[1,1], [2,1], [3,1], 
             [1,2],        [3,2], 
             [1,3], [2,3], [3,3]].sort
      end
    end

    context "all water" do
      it "returns 0 tiles" do
        villager.traversable_from([30,1]).should == []
      end
    end

    context "mixed" do
      it "returns only the walkable tiles" do
        villager.traversable_from([15,2]).sort.should == 
            [[15,1],[15,3]].sort
      end
    end
  end
end