module PathStrategy
  module AStar
    def self.adjacency(coords)
      CoordinateCalculator.surrounding(coords)
    end

    def self.cost(coords, board)
      board.terrain_at(coords).walkable? ? 0 : 1
    end

    def self.distance(start, finish)
      CoordinateCalculator.distance_between(start, finish)
    end

    def self.find_path(start, goal, board)
      been_there = {}
      queue = PriorityQueue.new
      queue << [1, [start, [], 0]]
      result = nil

      while queue.any?
        spot, path_so_far, cost_so_far = queue.next
        
        unless been_there[spot]      
          newpath = path_so_far + [spot]

          if spot == goal
            return Path.new_from_absolutes(newpath)
          else
            been_there[spot] = true

            adjacency(spot).each do |newspot|
              next if been_there[newspot]
              tcost = cost(newspot, board)
              next unless tcost
              newcost = cost_so_far + tcost
              queue << [newcost + distance(goal, newspot),
                         [newspot, newpath, newcost]]
            end
          end
        end
      end

      return nil
    end
  end
end