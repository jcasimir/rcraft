module Gatherer
  attr_accessor :gathering_timer, :resource_gather_rate,
                :gathering_at, :resources

  def time_to_gather_resources
    gathering_timer.period
  end

  def time_to_gather_resources=(period)
    gathering_timer.period = period
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