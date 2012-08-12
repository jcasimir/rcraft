require 'spec_helper'

describe Terrain::Map do
  describe "#water_coverage" do
    it "reflects the percentage of the map covered by water" do
      map = Terrain::Map.new(:dimensions => [10,1])
      map.water_at([0,0], [0,1])
      map.water_coverage.should == 20
    end
  end

  describe "#water_at" do
    it "sets a tile to water" do
      map = Terrain::Map.new(:dimensions => [1,1])
      map[[0,0]].should_not be_water
      map.water_at([0,0])
      map[[0,0]].should be_water
    end

    it "sets multiple tiles to water" do
      map = Terrain::Map.new(:dimensions => [4,1])
      map[[0,0]].should_not be_water
      map[[1,0]].should_not be_water
      map.water_at([0,0], [1,0])
      map[[0,0]].should be_water
      map[[1,0]].should be_water
    end
  end

  describe "#total_tiles" do
    it "counts tiles based on dimensions" do
      map = Terrain::Map.new(:dimensions => [2,5])
      map.total_tiles.should == 10
    end
  end

  context "#new" do
    it "creates a map" do
      Terrain::Map.new.should be_kind_of(Terrain::Map)
    end

    it "accepts and uses dimensions" do
      map = Terrain::Map.new(:dimensions => [2, 3])
      map.dimensions.should == [2,3]
    end

    it "uses default dimensions" do
      map = Terrain::Map.new
      map.total_tiles.should > 0
    end

    it "accepts and uses a randomization seed" do
      map = Terrain::Map.new(:seed => 1024)
      map.seed.should == 1024
    end

    it "uses a water coverage percentage" do
      map = Terrain::Map.new(:water_coverage => 20,
                             :dimensions => [5,5])
      map.water_coverage.should == 20
    end

    it "generates a map with no water" do
      map = Terrain::Map.new(:water_coverage => 0)
      map.water_coverage.should == 0
    end

    it "generates the identical map twice when the seed matches" do
      Terrain::Map.new(:seed => 10).should == Terrain::Map.new(:seed => 10)
    end

    it "generates different maps when the seed changes" do
      Terrain::Map.new(:seed => 1, :water_coverage => 10, :dimensions => [10,10]).should_not == 
        Terrain::Map.new(:seed => 2, :water_coverage => 10, :dimensions => [10,10])
    end
  end

  describe "#==" do
    it "equals another map with the same tile types at the same coordinates" do
      map = Terrain::Map.new(:dimensions => [2,2])
      map.water_at([0,0], [1,0])
      map2 = Terrain::Map.new(:dimensions => [2,2])
      map2.water_at([0,0], [1,0])
      map.should == map2
    end

    it "does not equal another map with different tile types at the same coordinates" do
      map = Terrain::Map.new(:dimensions => [2,2])
      map.water_at([0,0], [1,0])
      map2 = Terrain::Map.new(:dimensions => [2,2])
      map2.water_at([0,0], [1,1])
      map.should_not == map2
    end
  end

  describe "#to_s" do
    it "can represent all-land maps" do
      map = Terrain::Map.new(:dimensions => [2,2])
      map.to_s.should == "LL\nLL"
    end

    it "can represent mixed maps" do
      map = Terrain::Map.new(:dimensions => [2,2])
      map.water_at([0,0],[1,1])
      map.to_s.should == " L\nL "
    end
  end
end