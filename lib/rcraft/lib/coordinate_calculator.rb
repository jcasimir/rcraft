module CoordinateCalculator
  def self.add(coordinate, offset)
    [coordinate.first + offset.first,
     coordinate.last + offset.last]
  end

  def self.surrounding(coord, distance = 1)
    results = []
    (-distance..distance).each do |x_differential|
      (-distance..distance).each do |y_differential|
        unless (x_differential == 0 && y_differential == 0)
          result = add(coord,[x_differential, y_differential])
          if (result.first >= 0) && (result.last >= 0)
            results << result
          end
        end
      end
    end
    return results
  end

  def self.occupied_coordinates(coord, dimensions)
    results = []
    x, y = dimensions
    (0...x).each do |x_differential|
      (0...y).each do |y_differential|
        results << add(coord,[x_differential, y_differential])
      end
    end
    return results.sort
  end

  def self.distance_between(start, finish)
    Math.hypot(*offset(start,finish))
  end

  def self.offset(start, finish)
    [finish.first-start.first,finish.last-start.last]
  end
end