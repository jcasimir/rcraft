module Movable
  attr_accessor :moving_timer

  def time_to_move
    moving_timer.period
  end

  def move_to(coordinates)
    self.path = path_to(coordinates)
  end

  def attempt_to_move
    moving_timer.tick
    if moving_timer.ready?
      board.move(self, path.next!)
    end
  end

  def moving?
    !path.empty?
  end

  def next_move
    path.next
  end
end