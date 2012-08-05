class Player
  attr_accessor :name, :buildings

  DEFAULT_NAME = "Player"

  def initialize(params = {})
    @name = params[:name] || DEFAULT_NAME
    @buildings = []
  end

end