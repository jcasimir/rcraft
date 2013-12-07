require 'spec_helper'

describe "Playing a Text-UI Game" do
  let(:game){ Game.new }
  let(:player){ game.players.first }
  let(:board){ game.board }
  let(:visualizer){ Visualizers::Text.new(game) }
  
  it "renders a game" do
    expect(visualizer.render).to be
  end

end