class Camp
  attr_accessor :player, :dimensions, :training_times, :in_progress

  DEFAULT_DIMENSIONS = [2,2]
  DEFAULT_TRAINING_TIMES = { :villager => 20000 }

  def initialize(player = nil)
    @player = player
    @dimensions = DEFAULT_DIMENSIONS
    @training_times = DEFAULT_TRAINING_TIMES
    @in_progress = []
  end

  def tick
    in_progress.each do |entity|
      entity.tick
      spawn_entity(entity) if entity.done_training?
    end
  end

  def placed(coordinates)
    player.buildings << self
  end

  def create_villager
    Villager.new(self).tap do |v|
      self.in_progress << v
    end
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
end