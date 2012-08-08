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
      map = Terrain::Map.new(:dimensions => [10,1])
      map[[0,0]].should_not be_water
      map[[1,0]].should_not be_water
      map.water_at([0,0], [1,0])
      map[[0,0]].should be_water
      map[[1,0]].should be_water
    end
  end

  describe "#total_tiles" do
    it "counts tiles based on dimensions" do
      map = Terrain::Map.new(:dimensions => [10,2])
      map.total_tiles.should == 20
    end
  end

  context "#new" do
    it "creates a map" do
      Terrain::Map.new.should be_kind_of(Terrain::Map)
    end

    it "accepts and uses dimensions" do
      map = Terrain::Map.new(:dimensions => [200, 100])
      map.dimensions.should == [200,100]
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
      map = Terrain::Map.new(:dimensions => [200, 200],
                                           :seed => 1024,
                                           :water_coverage => 80)
      map.water_coverage.should == 80
    end

    it "generates a map with no water" do
      map = Terrain::Map.new(:dimensions => [200, 200],
                                           :seed => 1024,
                                           :water_coverage => 0)
      map.water_coverage.should == 0
    end

  end
end