class Camp
  attr_accessor :player, :dimensions, :training_times, :in_progress, 
                :training_slots, :training_queue, :board, :balance

  DEFAULT_DIMENSIONS = [2,2]
  DEFAULT_TRAINING_TIMES = { :villager => 20000 }
  DEFAULT_TRAINING_SLOTS = 1
  DEFAULT_TRAINING_COSTS = { :villager => 400 }
  DEFAULT_STARTING_BALANCE = 2000

  def initialize(player = nil)
    @player = player
    @dimensions = DEFAULT_DIMENSIONS
    @training_times = DEFAULT_TRAINING_TIMES
    @training_slots = DEFAULT_TRAINING_SLOTS
    @in_progress = []
    @training_queue = []
    @cost_to_train = DEFAULT_TRAINING_COSTS
    @balance = DEFAULT_STARTING_BALANCE
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
    if balance >= cost_to_train(:villager)
      Villager.new(self).tap do |v| 
        enqueue v
        move_from_queue
      end
    end
  end

  def enqueue(entity)
    entity_cost = cost_to_train(entity.to_key)
    if balance >= entity_cost
      self.balance -= entity_cost
      self.training_queue << entity
    end
  end

  def set_training_time_for(entity, cycles)
    training_times[entity] = cycles
  end

  def training_time_for(entity)
    training_times[entity]
  end

  def cost_to_train(entity_type)
    @cost_to_train[entity_type]
  end

  def set_cost_to_train(entity_type, cost)
    @cost_to_train[entity_type] = cost
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