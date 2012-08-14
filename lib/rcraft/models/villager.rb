class Villager
  attr_accessor :home, :player, :board

  DEFAULT_TIME_TO_GATHER_RESOURCES = 2000
  DEFAULT_RESOURCE_GATHER_RATE = 10
  DEFAULT_GATHERING_DISTANCE = 1
  DEFAULT_TIME_TO_MOVE = 500

  include PathStrategy::Villager
  include Movable
  include Gatherer
  include Trainable

  def initialize(home, &block)
    @home = home
    @player = home.player
    @training_time_remaining = home.training_time_for(:villager)
    @resources = []
    @resource_gather_rate = DEFAULT_RESOURCE_GATHER_RATE
    @gathering_timer = Timer.new(DEFAULT_TIME_TO_GATHER_RESOURCES)
    @moving_timer = Timer.new(DEFAULT_TIME_TO_MOVE)
    @gathering_distance = DEFAULT_GATHERING_DISTANCE
  end

  def defaults
    {:gathering_distance => 1,
     :maximum_resources  => 100,
     :deposit_distance   => 1}
  end

  def villager?
    true
  end

  def tick
    if in_training?
      self.training_time_remaining -= 1
    elsif moving?
      self.attempt_to_move
    elsif gathering?
      self.attempt_to_gather
    end
  end

  def placed_on(board)
    self.board = board
  end

  def to_key
    :villager
  end
end