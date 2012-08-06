class Board
  attr_accessor :size, :buildings, :grid

  DEFAULT_SIZE = [100,100]

  def initialize(param_size = DEFAULT_SIZE)
    @size = param_size
    @buildings = []
    @grid = build_grid(size)
  end

  def tick
    buildings.each(&:tick)
  end

  def place(building, coordinates)
    grid[coordinates] << building
    buildings << building
    building.placed_on(self)
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