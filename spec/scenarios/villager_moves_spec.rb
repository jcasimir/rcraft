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

    it "goes diagonally" do
      board.place(villager, [0,0])
      villager.move_to([3,3])
      (villager.time_to_move * 3).times{ board.tick }
      board.coordinates_for(villager).should == [3,3]
    end

    it "can walk more X than Y" do
      board.place(villager, [0,0])
      villager.move_to([5,3])
      (villager.time_to_move * 5).times{ board.tick }
      board.coordinates_for(villager).should == [5,3]
    end

    it "can walk more Y than X" do
      board.place(villager, [0,0])
      villager.move_to([3,5])
      (villager.time_to_move * 5).times{ board.tick }
      board.coordinates_for(villager).should == [3,5]
    end

    it "can't walk off the map" do
      board.place(villager, [0,0])
      villager.move_to([-1, -1])
      villager.time_to_move.times{ board.tick }
      board.coordinates_for(villager).should == [0,0]
    end
  end

  context "when it encounters a simple obstruction" do
    it "goes around it" do
      board.place(villager, [0,0])
      board.make_terrain(:water, [0,1])
      villager.move_to([2,0])
      villager.time_to_move.times{ board.tick }
      board.coordinates_for(villager).should_not == [1,0]
      villager.time_to_move.times{ board.tick }
      board.coordinates_for(villager).should == [2,0]
    end
  end
end