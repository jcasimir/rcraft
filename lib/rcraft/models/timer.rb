class Timer
  attr_accessor :period, :current

  def initialize(period)
    @period = @current = period
  end

  def reset
    self.current = period
  end

  def tick
    self.current = period if ready?
    self.current -= 1
  end

  def ready?
    current == 0
  end

  def period=(new_period)
    @current = @period = new_period
  end
end