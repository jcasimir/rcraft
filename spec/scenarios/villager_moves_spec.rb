require 'spec_helper'

describe "Villager moves" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:camp){ Camp.new(player) }
  let(:villager){ Villager.new(camp).train! }

  before(:each) do
    board.place(villager, [0,0])
  end

  context "when unobstructed" do
    it "goes in a straight line" do
      villager.move_to([5,0])
      board.tick while villager.moving?
      board.coordinates_for(villager).should == [5,0]
    end

    it "goes diagonally" do
      villager.move_to([3,3])
      board.tick while villager.moving?
      board.coordinates_for(villager).should == [3,3]
    end

    it "can walk more X than Y" do
      villager.move_to([5,3])
      board.tick while villager.moving?
      board.coordinates_for(villager).should == [5,3]
    end

    it "can walk more Y than X" do
      villager.move_to([3,5])
      board.tick while villager.moving?
      board.coordinates_for(villager).should == [3,5]
    end

    it "can't walk off the map" do
      villager.move_to([-1, -1])
      board.tick while villager.moving?
      board.coordinates_for(villager).should == [0,0]
    end
  end

  context "when it encounters a simple obstruction" do
    it "goes around it" do
      board.make_terrain(:water, [1,0])
      villager.move_to([2,0])
      villager.time_to_move.times{ board.tick }
      board.coordinates_for(villager).should_not == [1,0]
      villager.time_to_move.times{ board.tick }
      board.coordinates_for(villager).should == [2,0]
    end
  end

  context "when it encounters a complex obstruction" do
    it "goes around it" do
      board.make_terrain(:water, [1,0])
      board.make_terrain(:water, [1,1])
      board.make_terrain(:water, [2,1])
      board.make_terrain(:water, [3,1])
      villager.move_to([2,0])
      (villager.path.count * villager.time_to_move).times{ board.tick }
      board.coordinates_for(villager).should == [2,0]
    end
  end

  context "#move_to" do
    it "starts moving" do
      villager.move_to([3,0])
      villager.should be_moving
    end

    it "finishes moving" do
      villager.move_to([3,0])
      board.should_receive(:move).exactly(3).times
      (3 * villager.time_to_move).times{ villager.tick }
      villager.should_not be_moving
    end
  end

  context "#time_to_move_to" do
    it "returns the number of ticks to move to a spot" do
      villager.time_to_move_to([2,0]).should == villager.time_to_move * 2
    end
  end
end