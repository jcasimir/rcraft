class ResourceDeposit
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def resources?
    true
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