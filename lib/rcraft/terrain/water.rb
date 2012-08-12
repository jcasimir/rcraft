module Terrain
  class Water
    include Tile

    def walkable?
      false
    end

    def water?
      true
    end

    def land?
      false
    end

    def to_s
      " "
    end
  end
end