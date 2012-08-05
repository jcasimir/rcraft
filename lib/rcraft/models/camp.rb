class Camp
  attr_accessor :player, :dimensions

  DEFAULT_DIMENSIONS = [2,2]

  def initialize(player = nil)
    @player = player
    @dimensions = DEFAULT_DIMENSIONS
  end

  def placed(coordinates)
    player.buildings << self
  end
end