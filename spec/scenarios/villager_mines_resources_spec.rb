require 'spec_helper'

describe "Villager Gathers Resources" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }
  let(:villager){ Villager.new(camp).train! }

  before(:each) do
    board.place(camp, [0,0])
    board.place(villager, [2,0])
    board.spawn_resource(ResourceDeposit.new(10000), [5,0])
  end

  context "#gather_resources" do
    context "when far from the resources" do
      before(:each) do
        villager.gather_resources([5,0])
      end

      it "will begin moving" do
        villager.gather_resources([5,0])
        villager.should be_moving
      end

      it "moves close to the resources" do
        villager.time_to_move_to([4,0]).times{ game.tick }
        villager.current_position.should == [4,0]
        villager.should_not be_moving
      end
    end

    context "when next to the resources" do
      before(:each) do
        board.move(villager, [4,0])
        villager.gather_resources([5,0])
        villager.time_to_gather_resources.times{ villager.tick }
      end

      it "gathers exactly on the cycle" do
        villager.resources.should_not be_empty
      end

      it "gathers only every X cycles" do
        on_cycle = villager.resources_value
        2.times{ villager.tick }
        villager.resources_value.should == on_cycle
      end

      it "diminishes the resources" do
        board.resource_value_at([5,0]).should < 10000
      end

      it "collects resources until full" do
        villager.tick until villager.resources_full?
        villager.resources_value.should == villager.maximum_resources
      end

      it "returns to the nearest camp" do
        villager.tick until villager.resources_full?
        villager.destination.should == camp
      end
    end
  end

  context "villager#nearest_depository" do
    it "finds the nearest depository to a coordinate" do
      villager.nearest_depository.should == camp
    end
  end
end