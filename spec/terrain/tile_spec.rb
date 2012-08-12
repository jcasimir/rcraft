require 'spec_helper'

describe Terrain::Tile do
  class DummyTile
    include Terrain::Tile
  end

  let(:tile){ DummyTile.new }

  describe "#==" do
    it "equals another tile of the same type" do
      tile.should == DummyTile.new
    end
  end
end