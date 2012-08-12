require 'spec_helper'

describe "Villager Mines Resources" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }
  let(:villager){ Villager.new(camp).train! }

  before(:each) do
    board.place(camp, [0,0])
    board.place(villager, [2,0])
    board.spawn_resource(ResourceDeposit.new(10000), [5,0])
    villager.gather_resources([5,0])
  end

  it "moves to gather the resources" do
    villager.time_to_move_to([4,0]).times{ game.tick }
    villager.current_position.should == [4,0]
    game.tick
    villager.should be_gathering_resources
  end

  it "can reap value from the resources" do
    pending
    villager.time_to_gather_resources.times{ game.tick }
    board.resource_value_at([5,0]).should < 10000
    villager.resources_value.should > 0
  end

  it "collects resources until full" do
    pending
    until villager.resources_full?
      board.tick
    end
    villager.resources_value.should == villager.maximum_resources
    villager.destination.should == camp
  end
end