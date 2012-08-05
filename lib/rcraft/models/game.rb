class Game
  attr_accessor :board, :clock, :players

  def initialize
    @board = Board.new
    @clock = 0
    @players = [ Player.new(:name => "Player 1") ]
  end

  def tick
    self.clock += 1
  end
end