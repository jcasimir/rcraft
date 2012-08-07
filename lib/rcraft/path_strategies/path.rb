module PathStrategy
  class Path
    attr_accessor :path

    def initialize(moves)
      @path = moves
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

    def ==(other)
      self.path == other
    end
  end
end