require 'spec_helper'

describe Villager do
  class Home
    def training_time_for(entity)
      10
    end

    def player
      "player 1"
    end
  end

  let(:home){ Home.new }

  let(:villager){ Villager.new(home) }

  it "has a home" do
    villager.home.should == home
  end

  it "belongs to a player" do
    villager.player.should == home.player
  end

  context "#villager?" do
    it "is" do
      villager.should be_villager
    end
  end

  context "#training_time_remaining" do
    it "goes from the build time to zero" do
      villager.training_time_remaining.should == home.training_time_for(:villager)
      home.training_time_for(:villager).times{ villager.tick }
      villager.training_time_remaining.should == 0
    end
  end
end