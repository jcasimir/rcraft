class Board
  attr_accessor :size, :entities, :grid

  DEFAULT_SIZE = [100,100]

  def initialize(param_size = DEFAULT_SIZE)
    @size = param_size
    @entities = []
    @grid = build_grid(size)
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

  def move(entity, offset)
    current = coordinates_for(entity)
    grid[current].delete(entity)
    target = CoordinateCalculator.add(current,offset)
    grid[target] << entity
  end

private
  def build_grid(size)
    x_max, y_max = size
    set = {}
    (0..x_max).each do |x|
      (0..y_max).each do |y|
        set[[x,y]] = []
      end
    end
    return set
  end
end