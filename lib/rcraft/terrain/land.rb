module Terrain
  class Land
    include Tile

    def walkable?
      true
    end

    def water?
      false
    end

    def land?
      true
    end

    def to_s
      "L"
    end
  end
end