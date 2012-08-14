module PathStrategy
  module Villager
    attr_accessor :path, :pathfinder

    def path_to(target, range = 0)
      AStar.find_path(current_position, target, board, range)
    end

    def current_position
      board.coordinates_for(self)
    end

    def traversable_from(start)
      CoordinateCalculator.surrounding(start).select do |coords|
        !board.blocked?(coords)
      end
    end
  end
end