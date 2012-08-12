module Terrain
  module TileSorter
    def self.shuffle_select(tiles, seed, quantity)
      shuffle(tiles, seed).take(quantity)
    end

    def self.shuffle(objects, seed)
      objects.sort_by do |coords, tile|
        compound = ((coords.first+2)*seed + coords.last).to_s
        digest = Digest::SHA2.hexdigest(compound)
        digest
      end
    end
  end
end