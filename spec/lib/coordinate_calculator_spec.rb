require 'spec_helper'

describe CoordinateCalculator do
  context ".add" do
    it "correctly adds a coordinate and an offset" do
      CoordinateCalculator.add([1,2], [4,5]).should == [5,7]
    end
  end

  context ".surrounding" do
    context "with a distance of 1" do
      it "returns the coordinates one step away" do
        CoordinateCalculator.surrounding([2,2]).sort.should == 
          [[1,1], [2,1], [3,1], 
           [1,2],        [3,2], 
           [1,3], [2,3], [3,3]].sort
      end
    end

    context "with a distance of 2" do
      it "returns the coordinates two steps away" do
        CoordinateCalculator.surrounding([2,2], 2).sort.should == 
          [[0,0], [1,0], [2,0], [3,0], [4,0],
           [0,1], [1,1], [2,1], [3,1], [4,1],
           [0,2], [1,2],        [3,2], [4,2],
           [0,3], [1,3], [2,3], [3,3], [4,3],
           [0,4], [1,4], [2,4], [3,4], [4,4]].sort
      end
    end
  end

  context ".offset" do
    context "when they're different" do
      it "returns the difference" do
        CoordinateCalculator.offset([0,0], [3,1]).should == [3,1]
      end
    end

    context "when they're the same" do
      it "returns zeros" do
        CoordinateCalculator.offset([3,1], [3,1]).should == [0,0]
      end
    end
  end
end