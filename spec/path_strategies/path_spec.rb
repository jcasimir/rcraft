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
end