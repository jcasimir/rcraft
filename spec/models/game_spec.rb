require 'spec_helper'

describe Game do
  let(:game) { Game.new }

  context ".new" do
    it "exists" do
      expect{game}.to_not raise_error
    end

    it "sets the clock to zero" do
      game.clock.should == 0
    end
  end

  context "#board" do
    it "is a Board" do
      game.board.should be_kind_of(Board)
    end
  end

  context "#tick" do
    it "advances the clock" do
      expect{ game.tick }.to change{ game.clock }.by(1)
    end

    it "tells the board to tick" do
      game.board.should_receive :tick
      game.tick
    end
  end

  context "#players" do
    it "has players" do
      game.players.first.should be_kind_of(Player)
    end
  end
end