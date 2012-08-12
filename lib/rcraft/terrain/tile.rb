module Terrain
  module Tile
    def ==(other)
      self.class == other.class
    end
  end
end