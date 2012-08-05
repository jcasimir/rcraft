require 'spec_helper'

describe Player do
  let(:player) { Player.new }

  context ".new" do
    it "accepts a name" do
      player = Player.new(:name => "Sample")
      player.name.should == "Sample"
    end

    it "sets a default name" do
      player.name.length.should > 0
    end
  end
end