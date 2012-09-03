class ResourceDeposit
  attr_accessor :value, :maximum_gatherers, :gatherers

  DEFAULT_MAXIMUM_GATHERERS = 8

  def initialize(value)
    @value = value
    @maximum_gatherers = DEFAULT_MAXIMUM_GATHERERS
    @gatherers = []
  end

  def available?
    gatherers.count < maximum_gatherers
  end

  def resources?
    true
  end

  def add_gatherer(gatherer)
    if available? && !gatherers.include?(gatherer)
      gatherers << gatherer
    end
  end

  def remove_gatherer(gatherer)
    gatherers.delete(gatherer)
  end

  def gather(quantity)
    if quantity < value
      self.value -= quantity
      ResourcePack.new(quantity)
    else
      ResourcePack.new(empty!)
    end
  end

  def empty?
    value == 0
  end

  def empty!
    value.tap{ self.value = 0 }
  end
end