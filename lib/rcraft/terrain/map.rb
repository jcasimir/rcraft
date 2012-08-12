require 'digest/sha2'

module Terrain
  class Map
    attr_accessor :dimensions, :seed, :tiles, :water_coverage_percentage

    DEFAULT_DIMENSIONS = [5,5]
    DEFAULT_WATER_COVERAGE_PERCENTAGE = 0

    def initialize(params = {})
      @dimensions = params[:dimensions] || DEFAULT_DIMENSIONS
      @seed = params[:seed] || rand(10000)
      @tiles = {}
      @water_coverage_percentage = params[:water_coverage] || DEFAULT_WATER_COVERAGE_PERCENTAGE
      build_tiles
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

    def ==(other)
      tiles.all? do |coords, tile|
        tile == other[coords]
      end
    end

    def to_s
      (0...dimensions.first).collect do |x|
        (0...dimensions.last).collect do |y|
          tiles[[x,y]].to_s
        end.join
      end.join("\n")
    end

  private

    def build_tiles
      build_land
      build_water
    end

    def build_land
      (0...dimensions.first).each do |x|
        (0...dimensions.last).each do |y|
          tiles[[x,y]] = Land.new
        end
      end      
    end

    def build_water
      quantity = (total_tiles * water_coverage_percentage)/100
      shuffled = TileSorter.shuffle_select(tiles, seed, quantity)
      watered = 0
      orphan_cycle = 2
      until watered == quantity
        if orphan_cycle == 0
          threshold = 2
          orphans = tiles.select do |coords, tile|
            tile && !tile.water? && 
            (CoordinateCalculator.surrounding(coords).count{ |c| 
              (tiles[c] && tiles[c].land?) } <= threshold)
          end

          orphans.each do |o_coords, tile|
            if watered < quantity
              tiles[o_coords] = Water.new
              watered += 1
            end
          end

          orphan_cycle = 2
        else
          orphan_cycle -= 1
        end

        target = shuffled.shift.first
        close_surrounds = CoordinateCalculator.surrounding(target, 2)
        distant_surrounds = CoordinateCalculator.surrounding(target, 4).shuffle.take(rand(49))
        (target + close_surrounds + distant_surrounds).each do |coords|
          if watered < quantity && tiles[coords] && !tiles[coords].water?
            tiles[coords] = Water.new
            watered += 1
          end
        end
      end
    end
  end
end