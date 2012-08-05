class Player
  attr_accessor :name, :buildings, :villagers

  DEFAULT_NAME = "Player"

  def initialize(params = {})
    @name = params[:name] || DEFAULT_NAME
    @buildings = []
    @villagers = []
  end

  def add_entity(entity)
    self.villagers << entity if entity.villager?
  end

end