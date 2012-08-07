require 'spec_helper'

describe "Placing a Camp" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }

  def build_camp(coordinates = [0,0])
    board.place(camp, coordinates)
  end

  before(:each) do
    game.tick
    build_camp
    game.tick
  end

  it "builds a camp" do
    player.buildings.count.should == 1
    board.entities.count.should == 1
  end

  it "can create a villager" do
    player.villagers.count.should == 0
    camp.create_villager
    camp.training_time_for(:villager).times do
      game.tick
    end
    player.villagers.count.should == 1
  end

  it "can queue villagers" do
    camp.training_slots = 1
    camp.set_training_time_for(:villager, 2)
    villager_1 = camp.create_villager
    villager_2 = camp.create_villager
    camp.in_progress.should include(villager_1)
    camp.in_progress.should_not include(villager_2)
    2.times{ camp.tick }
    camp.in_progress.should_not include(villager_1)
    camp.in_progress.should include(villager_2)
  end
end