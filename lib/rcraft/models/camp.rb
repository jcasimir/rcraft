class Camp
  attr_accessor :player, :dimensions, :training_times, :in_progress, 
                :training_slots, :training_queue, :board

  DEFAULT_DIMENSIONS = [2,2]
  DEFAULT_TRAINING_TIMES = { :villager => 20000 }
  DEFAULT_TRAINING_SLOTS = 1

  def initialize(player = nil)
    @player = player
    @dimensions = DEFAULT_DIMENSIONS
    @training_times = DEFAULT_TRAINING_TIMES
    @training_slots = DEFAULT_TRAINING_SLOTS
    @in_progress = []
    @training_queue = []
  end

  def tick
    advance_progress
    move_from_queue
  end

  def placed_on(board)
    player.buildings << self
    self.board = board
  end

  def create_villager
    Villager.new(self).tap do |v| 
      enqueue v
      move_from_queue
    end
  end

  def enqueue(entity)
    self.training_queue << entity
  end

  def set_training_time_for(entity, cycles)
    training_times[entity] = cycles
  end

  def training_time_for(entity)
    training_times[entity]
  end

  def spawn_entity(entity)
    in_progress.delete(entity)
    player.add_entity(entity)
  end

  def training_slots_open?
    training_slots_open > 0
  end

  def training_slots_open
    training_slots - in_progress.count
  end

private

  def advance_progress
    in_progress.each do |entity|
      entity.tick
      spawn_entity(entity) if entity.trained?
    end
  end

  def move_from_queue
    if training_queue.any? && training_slots_open?
      in_progress.push(*training_queue.shift(training_slots_open))
    end
  end
end