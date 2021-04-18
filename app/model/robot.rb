# frozen_string_literal: true

require 'model/direction'

module ToyRobot
  class Robot
    attr_reader :board, :current_coordinate, :direction

    # @param  [Board] board
    # @return [void]
    def set_board(board)
      @board = board
    end

    # @param  [Symbol] direction_name
    # @param  [Fixnum] x
    # @param  [Fixnum] y
    # @return [Boolean]
    def place(direction_name:, x:, y:)
      # return false unless palced? && coordinate_on_table?(x, y)

      if !placed? && coordinate_on_table?(x, y)
        @direction = Direction.get_direction(direction_name)
        set_coordinate(Coordinate.new(x: x, y: y))
        true
      else
        false
      end
    end

    # @return [Boolean]
    def turn_left
      return false unless on_board?

      @direction = Direction.get_left_direction(@direction.name)
      true
    end

    # @return [Boolean]
    def turn_right
      return false unless on_board?

      @direction = Direction.get_right_direction(@direction.name)
      true
    end

    # @return [Boolean]
    def move
      return false unless moveable?

      set_coordinate(@direction.coordinate)
      true
    end

    # @return [Array]
    def report
      return [] unless on_board?

      [@direction.name, @current_coordinate.x, @current_coordinate.y]
    end

    # @return [Boolean]
    def placed?
      @board && @current_coordinate && @direction
    end

    # @param  [Fixnum] x
    # @param  [Fixnum] y
    # @return [Boolean]
    def coordinate_on_table?(x, y)
      !@board.nil? && x <= @board.width && y <= @board.height
    end

    # @param  [Coordinate] coordinate
    # @return [Void]
    def set_coordinate(coordinate)
      if @current_coordinate.nil?
        @current_coordinate = coordinate.clone
      else
        @current_coordinate.add_coordinate(coordinate)
      end
    end

    # @return [Boolean]
    def on_board?
      !@board.nil? && !@current_coordinate.nil? && !@direction.nil?
    end

    # @return [Boolean]
    def moveable?
      return false unless on_board?

      coordinate = @direction.coordinate
      if @current_coordinate.x + coordinate.x >= 0 &&
         @current_coordinate.x + coordinate.x < @board.width &&
         @current_coordinate.y + coordinate.y >= 0 &&
         @current_coordinate.y + coordinate.y < @board.height
        true
      else
        false
      end
    end

    private :placed?, :coordinate_on_table?, :set_coordinate, :on_board?, :moveable?
  end
end
