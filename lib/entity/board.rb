module ToyRobot
  class Board
    attr_reader :width, :height

    WIDTH  = 5
    HEIGHT = 5

    # @param {Integer} width
    # @param {Integer} height
    def initialize(width = WIDTH, height = HEIGHT)
      if width > 0 and height > 0
        @width  = width
        @height = height
      else
        @width  = WIDTH
        @height = HEIGHT
      end
    end
  end
end