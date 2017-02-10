module ToyRobot
  class Coordinate
    attr_accessor :x, :y

    # @param {Integer} x
    # @param {Integer} y
    def initialize(x = 0, y = 0)
      @x = x
      @y = y
    end
  end
end
