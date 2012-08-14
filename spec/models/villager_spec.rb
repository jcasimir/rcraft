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

  context "#to_key" do
    it "is :villager" do
      villager.to_key == :villager
    end
  end

  context "#training_time_remaining" do
    it "goes from the build time to zero" do
      villager.training_time_remaining.should == home.training_time_for(:villager)
      home.training_time_for(:villager).times{ villager.tick }
      villager.training_time_remaining.should == 0
    end
  end

  context "#placed_on" do
    it "sets the board" do
      board = Board.new
      villager.placed_on(board)
      villager.board.should == board
    end
  end

  context "#resources_value" do
    it "is the total of carried resources" do
      villager.resources_value.should == 0
      villager.resources << ResourcePack.new(5)
      villager.resources_value.should == 5
    end
  end

  context "#train!" do
    it "marks the villager as trained" do
      villager.train!.should be_trained
    end
  end
end