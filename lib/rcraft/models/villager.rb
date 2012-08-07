class Villager
  attr_accessor :home, :player, :training_time_remaining, :board, 
                :resources, :gathering_timer, :resource_gather_rate,
                :gathering_at

  DEFAULT_TIME_TO_GATHER_RESOURCES = 2000
  DEFAULT_RESOURCE_GATHER_RATE = 10
  DEFAULT_TIME_TO_MOVE = 500
  include PathStrategy::Villager
  include Movable

  def initialize(home)
    @home = home
    @player = home.player
    @training_time_remaining = home.training_time_for(:villager)
    @resources = []
    @resource_gather_rate = DEFAULT_RESOURCE_GATHER_RATE
    @gathering_timer = Timer.new(DEFAULT_TIME_TO_GATHER_RESOURCES)
    @moving_timer = Timer.new(DEFAULT_TIME_TO_MOVE)
  end

  def villager?
    true
  end

  def tick
    if in_training?
      self.training_time_remaining -= 1
    elsif gathering?
      self.attempt_to_gather
    elsif moving?
      self.attempt_to_move
    end
  end

  def time_to_gather_resources
    gathering_timer.period
  end

  def time_to_gather_resources=(period)
    gathering_timer.period = period
  end

  def in_training?
    training_time_remaining > 0
  end

  def train!
    self.training_time_remaining = 0
    self
  end

  def trained?
    !in_training?
  end

  def placed_on(board)
    self.board = board
  end

  def resources_value
    resources.map(&:value).inject(:+) || 0
  end

  def gather_resources(coordinates)
    self.gathering_at = coordinates
  end

  def gathering?
    gathering_at
  end

  def attempt_to_gather
    gathering_timer.tick
    if gathering_timer.ready?
      deposit = board.resource_at(gathering_at)
      resources << deposit.gather(resource_gather_rate)
    end
  end
end