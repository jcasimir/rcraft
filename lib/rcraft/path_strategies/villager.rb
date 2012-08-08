module PathStrategy
  module Villager
    attr_accessor :path, :pathfinder

    def path_to(target)
      AStar.find_path(current_position, target, board)
    end

    def current_position
      board.coordinates_for(self)
    end

    def traversable_from(start)
      CoordinateCalculator.surrounding(start).select do |coords|
        board.terrain_at(coords).walkable?
      end
    end

    def simple_path_to(target)
      start = board.coordinates_for(self)
      x_differential = target.first - start.first
      y_differential = target.last - start.last
      results = []
      [x_differential, y_differential].max.times do
        if x_differential > 0
          x = 1
          x_differential -= 1
        else
          x = 0
        end

        if y_differential > 0
          y = 1
          y_differential -= 1
        else
          y = 0
        end

        results << [x,y]
      end
      Path.new(results)
    end
  end
end