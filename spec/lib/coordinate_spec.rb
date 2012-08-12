require 'spec_helper'

describe Coordinate do
  let(:coordinate){ Coordinate.new(3,4) }
  describe ".new" do
    it "takes an array of values and makes them accessible" do
      coordinate.x.should == 3
      coordinate.y.should == 4
    end
  end

  context ".add" do
    it "correctly adds an offset" do
      coordinate.add(1,2).should == Coordinate.new(4,6)
    end
  end

  context ".neighbors" do
    context "with a distance of 1" do
      it "returns the coordinates one step away" do
        coordinate.neighbors.should == 
          [[2,3], [3,3], [4,3], 
           [2,4],        [4,4], 
           [2,5], [3,5], [4,5]].sort
      end
    end
  end
end