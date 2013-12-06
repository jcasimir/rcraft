module Gatherer
  attr_accessor :gathering_timer, :resource_gather_rate,
                :gathering_at, :resources, :gathering_distance,
                :maximum_resources

  def gathering_distance
    @gathering_distance ||= defaults[:gathering_distance]
  end

  def maximum_resources
    @maximum_resources ||= defaults[:maximum_resources]
  end

  def resources_full?
    resources_value >= maximum_resources
  end

  def can_gather?
    !resources_full?
  end

  def time_to_gather_resources
    gathering_timer.period
  end

  def time_to_gather_resources=(period)
    gathering_timer.period = period
  end

  def resources_value
    resources ? resources.map(&:value).inject(0, :+) : 0
  end

  def within_gathering_range_of?(coordinates)
    CoordinateCalculator.distance_between(self.current_location, coordinates).to_i <= gathering_distance
  end

  def gather_resources(coordinates)
    self.gathering_at = coordinates
    unless within_gathering_range_of?(coordinates)
      move_within_range_of(coordinates, gathering_distance) 
    end
  end

  def gathering?
    gathering_at && deposit.resources?
  end

  def attempt_to_gather
    gathering_timer.tick
    gather if gathering_timer.ready?
    return_to_depository if resources_full?
  end

  def gather
    if deposit.available?
      deposit.add_gatherer(self)
      resources << deposit.gather(resource_gather_rate)
    end
  end

  def return_to_depository    
    deposit.remove_gatherer(self)
    self.destination = nearest_depository
    move_within_range_of(destination.location, defaults[:deposit_distance])
  end

  def deposit
    @deposit ||= board.resource_at(gathering_at)
  end

  def nearest_depository
    player.depositories.sort_by do |dep| 
      time_to_move_to(dep.location)
    end.first
  end
end