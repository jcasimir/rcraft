module PathStrategy
  class Villager
    attr_accessor :path

    def initialize(entity, target, board)
      @path = find_path(entity, target, board)
    end

    def next
      path.last
    end

    def next!
      path.pop
    end

    def empty?
      path.empty?
    end

  private

    def find_path(entity, target, board)
      start = board.coordinates_for(entity)
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
      results
    end
  end
end