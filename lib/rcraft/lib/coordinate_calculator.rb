module CoordinateCalculator
  def self.add(coordinate, offset)
    [coordinate.first + offset.first,
     coordinate.last + offset.last]
  end
end