require 'spec_helper'

describe "Placing a Camp" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }

  before(:each) do
    board.place(camp, [0,0])
    game.tick
  end

  describe "#location" do
    it "finds the correct coordinates" do
      camp.location.should == [0,0]
    end
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

  context "camp#spawn_entity" do
    let!(:villager){ camp.create_villager }

    it "removes the entity from the build queue" do
      camp.in_progress.should include(villager)
      player.should_receive(:add_entity).with(villager)
      camp.spawn_entity(villager)
      camp.in_progress.should_not include(villager)
    end

    it "puts the entity on the board" do
      camp.spawn_entity(villager)
      villager.current_location.should be
    end
  end

  context "camp#spawn_location" do
    context "when surrounded by open space" do
      it "finds the bottom right corner coordinate outside the camp itself" do
        camp.spawn_location.should == [2,2]
      end  
    end
  end

  context "camp#surrounding_coordinates" do
    it "finds a list of all the coordinates around the camp" do
      camp.surrounding_coordinates.should == 
        [              [2,0],
                       [2,1],
         [0,2], [1,2], [2,2]].sort
    end
  end

  context "camp#occupied_coordinates" do
    it "finds the occupied coordinates" do
      camp.occupied_coordinates.should == [[0,0], [1,0], [0,1], [1,1]].sort
    end
  end
end