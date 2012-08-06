require 'spec_helper'

describe "Villager Mines Resources" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }
  let(:villager){ Villager.new(camp).train! }

  def build_camp(coordinates = [0,0])
    board.place(camp, coordinates)
  end

  before(:each) do
    game.tick
    build_camp
    game.tick
  end

  it "can reap value from the resources" do
    board.place(villager,[3,0])
    board.spawn_resource(ResourceDeposit.new(10000), [4,0])
    board.resource_value_at([4,0]).should == 10000
    villager.resources_value.should == 0
    villager.gather_resources([4,0])
    villager.time_to_gather_resources.times{ board.tick }
    board.resource_value_at([4,0]).should < 10000
    villager.resources_value.should > 0
  end
end