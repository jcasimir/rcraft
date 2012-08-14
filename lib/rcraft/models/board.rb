class Board
  attr_accessor :size, :entities, :grid, :terrain, :x_max, :y_max

  DEFAULT_SIZE = [100,100]

  def initialize(param_size = DEFAULT_SIZE)
    @size = param_size
    @entities = []
    @grid = build_grid(size)
    @terrain = {}
  end

  def tick
    entities.each(&:tick)
  end

  def place(entity, coordinates)
    grid[coordinates] << entity
    entities << entity
    entity.placed_on(self)
  end

  def coordinates_for(entity)
    coords, e = grid.detect{|coordinates, entities| entities.include?(entity)}
    return coords
  end

  def valid_coordinates?(coords)
    (coords.first >= 0) && 
    (coords.last  >= 0) &&
    (coords.first <= x_max) &&
    (coords.last <= y_max)
  end

  def entities_at(coordinates)
    grid[coordinates]
  end

  def resource_value_at(coordinates)
    resource = resource_at(coordinates)
    resource ? resource.value : 0
  end

  def resource_at(coordinates)
    entities_at(coordinates).detect{|e| e.resources?}
  end

  def spawn_resource(resource, coordinates)
    grid[coordinates] << resource
  end

  def move(entity, target)
    current = coordinates_for(entity)
    grid[current].delete(entity)
    grid[target] << entity
  end

  def make_terrain(type, coordinates)
    self.terrain[coordinates] = Terrain::Builder.build(type)
  end

  def terrain_at(coordinates)
    terrain[coordinates] || Terrain::Land.new
  end

  def blocked?(coordinates)
    !valid_coordinates?(coordinates)   ||
    !terrain_at(coordinates).walkable? 
    #entities_at(coordinates).any?{|e| e.blocker?}
  end

  def open?(coordinates)
    !blocked?(coordinates)
  end

private
  def build_grid(size)
    self.x_max, self.y_max = size
    set = {}
    (0..x_max).each do |x|
      (0..y_max).each do |y|
        set[[x,y]] = []
      end
    end
    return set
  end
end