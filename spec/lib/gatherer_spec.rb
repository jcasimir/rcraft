require 'spec_helper'

describe Gatherer do
  class DummyPlayer
    attr_reader :depositories

    def initialize
      @depositories = []
    end
  end

  class DummyGatherer
    include Gatherer
    include PathStrategy::Villager
    include Movable

    attr_accessor :player

    def initialize(player)
      @player = player
    end

    def defaults
      {:gathering_distance => 1}
    end

    def current_location
      [0,0]
    end
  end

  let(:player){ DummyPlayer.new }
  let(:gatherer){ DummyGatherer.new(player) }

  describe "#within_gathering_range_of?" do
    it "is true when close to the resources" do
      gatherer.within_gathering_range_of?([1,1]).should be
    end

    it "is false when far from the resources" do
      gatherer.within_gathering_range_of?([2,1]).should_not be
    end    
  end

  describe "#can_gather?" do
    it "is true if there's capacity left" do
      gatherer.maximum_resources = 0
      gatherer.can_gather?.should_not be
    end
  end
end