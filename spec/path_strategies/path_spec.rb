require 'spec_helper'

describe PathStrategy::Path do
  context "#new" do
    PathStrategy::Path.new([[1,0], [2,0]]).should == [[1,0], [2,0]]
  end

  context "#empty?" do
    let(:path){ PathStrategy::Path.new([]) }

    it "is true when the path is complete" do
      path.should be_empty
    end
  end

  context ".new_from_absolutes" do
    it "converts absolutes to offsets" do
      absolutes = [[1,1], [2,2], [3,2], [3,3]]
      PathStrategy::Path.new_from_absolutes(absolutes).should ==
        [[1,1], [1,0], [0,1]]
    end
  end
end