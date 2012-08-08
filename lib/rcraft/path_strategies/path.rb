module PathStrategy
  class Path
    attr_accessor :path

    def initialize(moves)
      @path = moves
    end

    def self.new_from_absolutes(moves)
      previous = moves.shift
      offsets = moves.collect do |target|
        offset = CoordinateCalculator.offset(previous, target)
        previous = target
        offset
      end
      PathStrategy::Path.new(offsets)
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

    def any?
      path.any?
    end

    def ==(other)
      self.path == other
    end

    def count
      path.count
    end
  end
end