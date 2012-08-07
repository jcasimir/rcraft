module Terrain
  module Builder
    def self.build(type)
      case type
        when :water then Terrain::Water.new
        when :land then Terrain::Land.new
      end
    end
  end
end