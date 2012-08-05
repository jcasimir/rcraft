class Player
  attr_accessor :name

  DEFAULT_NAME = "Player"

  def initialize(params = {})
    @name = params[:name] || DEFAULT_NAME
  end

end