module Terrain
  class Map
    attr_accessor :dimensions, :seed, :tiles

    DEFAULT_DIMENSIONS = [100,100]

    def initialize(params = {})
      @dimensions = params[:dimensions] || DEFAULT_DIMENSIONS
      @seed = params[:seed]
      @tiles = {}
      build_tiles(params[:water_coverage])
    end

    def water_coverage
      (tiles.count{|coords, tile| tile.water?} * 100)/total_tiles
    end

    def water_at(*coord_set)
      coord_set.each do |coords|
        tiles[coords] = Water.new
      end
    end

    def [](coords)
      tiles[coords]
    end

    def total_tiles
      dimensions.first * dimensions.last
    end

  private

    def build_tiles(water_coverage = nil)
      build_land
      build_water(water_coverage)
    end

    def build_land
      (0...dimensions.first).each do |x|
        (0...dimensions.last).each do |y|
          tiles[[x,y]] = Land.new
        end
      end      
    end

    def build_water(water_coverage)
      if water_coverage
        quantity = (total_tiles * water_coverage)/100
        water_targets = tiles.keys.sample(quantity)
        water_targets.each do |w|
          tiles[w] = Water.new
        end
      end
    end
  end
end