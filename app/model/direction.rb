# frozen_string_literal: true

require 'error/direction_invalid_value_error'
require 'error/direction_not_found_error'
require 'error/direction_name_not_found_error'
require 'error/direction_value_not_found_error'

module ToyRobot
  class Direction
    attr_reader :name, :coordinate

    DIRECTIONS = { NORTH: 0, EAST: 1, SOUTH: 2, WEST: 3 }.freeze

    INVERTED_DIRECTIONS = DIRECTIONS.invert

    # @param [Symbol] name
    # @param [Fixnum] x
    # @param [Fixnum] y
    # @raise [DirectionInvalidValueError]
    def initialize(name:, x:, y:)
      raise DirectionInvalidValueError, 'direction value is invalid' unless DIRECTIONS.key?(name)

      @name = name
      @coordinate = Coordinate.new(x: x, y: y)
    end

    class << self
      # @param  [Symbol] name
      # @return [Direction]
      # @raise  [DirectionNotFoundError]
      def direction(name)
        case name
        when :NORTH
          Direction.new(name: :NORTH, x: 0, y: 1)
        when :WEST
          Direction.new(name: :WEST, x: -1, y: 0)
        when :SOUTH
          Direction.new(name: :SOUTH, x: 0, y: -1)
        when :EAST
          Direction.new(name: :EAST, x: 1, y: 0)
        else
          raise DirectionNotFoundError, 'direction cannot be found by the given name'
        end
      end

      # @param  [Symbol] name
      # @return [Fixnum]
      # @raise  [DirectionValueNotFound]
      def find_value(name)
        value = DIRECTIONS.fetch(name, nil)
        value.nil? ? (raise DirectionValueNotFoundError, 'direction value cannot be found by the given name') : value
      end

      # @param  [Symbol] name
      # @return [Direction]
      # @raise  [ArgumentError]
      def left_direction(name)
        raise DirectionNotFoundError, 'direction cannot be found by the given name' unless DIRECTIONS.key?(name)

        current_value = find_value(name)
        next_value = (current_value - 1 + DIRECTIONS.size) % DIRECTIONS.size
        name = INVERTED_DIRECTIONS[next_value]
        direction(name)
      end

      # @param  [Direction] name
      # @return [Direction]
      # @raise  [ArgumentError]
      def right_direction(name)
        raise DirectionNotFoundError, 'direction cannot be found by the given name' unless DIRECTIONS.key?(name)

        current_value = find_value(name)
        next_value = (current_value + 1) % DIRECTIONS.size
        name = INVERTED_DIRECTIONS[next_value]
        direction(name)
      end
  end
  end
end
