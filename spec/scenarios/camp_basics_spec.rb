require 'spec_helper'

describe "Placing a Camp" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }

  def build_camp(coordinates = [0,0])
    board.place(camp, [0,0])
  end

  before(:each) do
    game.tick
    build_camp
    game.tick
  end

  it "builds a camp" do
    player.buildings.count.should == 1
    board.buildings.count.should == 1
  end

  it "creates a villager" do
    player.villagers.should == 0
    camp.create_villager
    camp.training_time_for(:villager).times do
      game.tick
    end
    player.villagers.should == 1
  end
end