require 'spec_helper'

describe "Villager moves" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }
  let(:villager){ Villager.new(camp).train! }

  context "when unobstructed" do
    it "goes in a straight line" do
      board.place(villager, [0,0])
      villager.move_to([5,0])
      (villager.time_to_move * 5).times{ board.tick }
      board.coordinates_for(villager).should == [5,0]
    end
  end
end