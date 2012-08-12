class Coordinate
  attr_accessor :x, :y

  def initialize(*coords)
    @x, @y = coords
  end

  def add(x_offset, y_offset)
    self.x += x_offset
    self.y += y_offset
    self
  end

  def ==(other)
    (x == other.x) && (y == other.y)
  end

  def neighbors
    CoordinateCalculator.surrounding([x,y])
  end
end