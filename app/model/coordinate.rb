# frozen_string_literal: true

module ToyRobot
  class Coordinate
    attr_reader :x, :y

    # @param [Fixnum] x
    # @param [Fixnum] y
    def initialize(x: 0, y: 0)
      @x = x
      @y = y
    end

    # @param  [Coordinate] coordinate
    # @return [Void]
    def add(coordinate)
      @x += coordinate.x
      @y += coordinate.y
    end
  end
end
