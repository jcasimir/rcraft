module Visualizers
  class Text
    attr_reader :game

    def initialize(input_game)
      @game = input_game
    end

    def render
      game.board.to_s
    end

  end
end