require 'spec_helper'

describe CoordinateCalculator do
  context ".add" do
    it "correctly adds a coordinate and an offset" do
      CoordinateCalculator.add([1,2], [4,5]).should == [5,7]
    end
  end
end