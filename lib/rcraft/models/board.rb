class Board
  attr_accessor :size

  DEFAULT_SIZE = [100,100]

  def initialize(param_size = DEFAULT_SIZE)
    @size = param_size
  end
end