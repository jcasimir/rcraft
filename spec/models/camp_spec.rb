require 'spec_helper'

describe Camp do
  let(:camp){ Camp.new }

  context ".new" do
    it "takes a player" do
      Camp.new("player 1").player.should == "player 1"
    end
  end

  context ".dimensions" do
    it "is 2x2" do
      camp.dimensions.should == [2,2]
    end
  end
end