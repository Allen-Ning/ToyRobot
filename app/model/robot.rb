# frozen_string_literal: true

require 'model/direction'

module ToyRobot
  class Robot
    attr_reader :board, :coordinate, :direction

    # @param  [Board] board
    # @param  [Symbol] direction_name
    # @param  [Fixnum] x
    # @param  [Fixnum] y
    # @return [Boolean]
    def place(board:, direction_name:, x:, y:)
      # return false unless palced? && coordinate_on_table?(x, y)

      # needs to change the logic here
      @board = board
      if !placed? && coordinate_on_table?(x, y)
        @direction = Direction.direction(direction_name)
        add_coordinate(Coordinate.new(x: x, y: y))
        true
      else
        false
      end
    end

    # @return [Boolean]
    def turn_left
      return false unless on_board?

      @direction = Direction.left_direction(@direction.name)
      true
    end

    # @return [Boolean]
    def turn_right
      return false unless on_board?

      @direction = Direction.right_direction(@direction.name)
      true
    end

    # @return [Boolean]
    def move
      return false unless moveable?

      add_coordinate(@direction.coordinate)
      true
    end

    # @return [Array]
    def report
      return [] unless on_board?

      [@direction.name, @coordinate.x, @coordinate.y]
    end

    private

    # @return [Boolean]
    def placed?
      @board && @coordinate && @direction
    end

    # @param  [Fixnum] x
    # @param  [Fixnum] y
    # @return [Boolean]
    def coordinate_on_table?(x, y)
      !@board.nil? && x <= @board.width && y <= @board.height
    end

    # @param  [Coordinate] coordinate
    # @return [Void]
    def add_coordinate(coordinate)
      if @coordinate.nil?
        @coordinate = coordinate.clone
      else
        @coordinate.add(coordinate)
      end
    end

    # @return [Boolean]
    def on_board?
      !@board.nil? && !@coordinate.nil? && !@direction.nil?
    end

    # @return [Boolean]
    def moveable?
      return false unless on_board?

      coordinate = @direction.coordinate
      if @coordinate.x + coordinate.x >= 0 &&
         @coordinate.x + coordinate.x < @board.width &&
         @coordinate.y + coordinate.y >= 0 &&
         @coordinate.y + coordinate.y < @board.height
        true
      else
        false
      end
    end
  end
end
