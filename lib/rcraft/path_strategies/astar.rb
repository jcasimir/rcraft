require 'set'

module PathStrategy
  module AStar
    def self.adjacency(coords)
      CoordinateCalculator.surrounding(coords)
    end

    def self.distance(start, finish)
      CoordinateCalculator.distance_between(start, finish)
    end

    def self.find_path(start, goal, board)
      past = Set.new
      queue = PriorityQueue.new
      queue << [1, [start, []]]

      while queue.any?
        current, path = queue.next
        
        unless past.include?(current)
          test_path = path << current

          if current == goal
            test_path.shift
            return Path.new(test_path)
          else
            past << current

            adjacency(current).each do |target|
              next if (past.include?(target) || board.blocked?(target))
              queue << [distance(goal, target), [target, test_path]]
            end
          end
        end
      end

      return nil
    end
  end
end