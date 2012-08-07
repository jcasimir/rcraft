module PathStrategy
  module Villager
    attr_accessor :path
    
    def set_path_to(target)
      self.path = path_to(target)
    end

    def path_to(target)
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