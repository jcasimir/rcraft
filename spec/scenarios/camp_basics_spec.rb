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

  context "when there are insufficient funds availabile" do
    before(:each) do
      camp.balance = 0
    end

    it "can't create a villager" do
      player.villagers.count.should == 0
      camp.create_villager.should_not be
      camp.training_time_for(:villager).times{ game.tick }
      player.villagers.count.should == 0
    end
  end

  context "when there are sufficient funds available" do
    before(:each) do
      camp.balance = camp.cost_to_train(:villager) * 5
    end

    it "can create a villager" do
      player.villagers.count.should == 0
      balance = camp.balance
      camp.create_villager
      camp.training_time_for(:villager).times{ game.tick }
      player.villagers.count.should == 1
      camp.balance.should == balance - camp.cost_to_train(:villager)
    end

    it "can queue villagers" do
      camp.training_slots = 1
      camp.set_training_time_for(:villager, 2)
      balance = camp.balance
      villager_1 = camp.create_villager
      villager_2 = camp.create_villager
      camp.balance.should == balance - 2*camp.cost_to_train(:villager)
      camp.in_progress.should include(villager_1)
      camp.in_progress.should_not include(villager_2)
      2.times{ camp.tick }
      camp.in_progress.should_not include(villager_1)
      camp.in_progress.should include(villager_2)
      camp.balance.should == balance - 2*camp.cost_to_train(:villager)
    end
  end
end