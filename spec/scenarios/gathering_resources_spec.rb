require 'spec_helper'

describe "Gathering Resources" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }

  def build_camp(coordinates = [0,0])
    camp = Camp.new(player)
    board.place(camp, [0,0])
  end

  it "runs correctly" do
    game.tick
    build_camp
    game.tick
    player.buildings.count.should == 1
    board.buildings.count.should == 1
  end
end