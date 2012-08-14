module Movable
  attr_accessor :moving_timer, :destination

  def time_to_move
    moving_timer.period
  end

  def time_to_move_to(coordinates)
    path_to(coordinates).count * time_to_move
  end

  def move_to(coordinates)
    self.path = path_to(coordinates) if board.valid_coordinates?(coordinates)
  end

  def move_within_range_of(coordinates, range)
    self.path = path_to(coordinates, range) if board.valid_coordinates?(coordinates)
  end

  def attempt_to_move
    moving_timer.tick
    if moving_timer.ready?
      board.move(self, path.next!)
    end
  end

  def moving?
    !!(path && path.any?)
  end

  def next_move
    path.next
  end

  def current_location
    board.coordinates_for(self)
  end
end