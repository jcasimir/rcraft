require 'spec_helper'

describe Terrain::TileSorter do
  let(:tiles){ {[0,0] => "a",
                [1,0] => "b",
                [0,1] => "c",
                [1,1] => "d"}.sort }

  describe ".shuffle" do
    it "shuffles a set of tiles" do
      Terrain::TileSorter.shuffle(tiles, 1).should_not == tiles
    end

    it "uses a repeatable shuffle" do
      Terrain::TileSorter.shuffle(tiles, 2).should == 
        Terrain::TileSorter.shuffle(tiles, 2)
    end

    it "is unique per seed" do
      Terrain::TileSorter.shuffle(tiles, 2).should_not == 
        Terrain::TileSorter.shuffle(tiles, 3)
    end
  end

  describe ".shuffle_select" do
    it "grabs QUANTITY elements" do
      Terrain::TileSorter.shuffle_select(tiles, 2, 2).count.should == 2
    end

    it "grabs the same QUANTITY elements" do
      Terrain::TileSorter.shuffle_select(tiles, 2, 2).should ==
        Terrain::TileSorter.shuffle_select(tiles, 2, 2)
    end

    it "grabs the unique QUANTITY elements per SEED" do
      Terrain::TileSorter.shuffle_select(tiles, 2, 2).should_not ==
        Terrain::TileSorter.shuffle_select(tiles, 3, 2)
    end
  end
end