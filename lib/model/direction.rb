# frozen_string_literal: true

require 'error/direction_invalid_value_error'
require 'error/direction_not_found_error'
require 'error/direction_name_not_found_error'
require 'error/direction_value_not_found_error'

module ToyRobot
  class Direction
    attr_reader :name, :coordinate

    DIRECTIONS = { NORTH: 0, WEST: 1, SOUTH: 2, EAST: 3 }.freeze
    INVERTED_DIRECTIONS = DIRECTIONS.invert

    # @param [Symbol] name
    # @param [Fixnum] x
    # @param [Fixnum] y
    # @raise [DirectionInvalidValueError]
    def initialize(name, x, y)
      raise DirectionInvalidValueError, 'direction value is invalid' unless DIRECTIONS.key? name

      @name = name
      @coordinate = Coordinate.new(x: x, y: y)
    end

    # @param  [Symbol] name
    # @return [Direction]
    # @raise  [DirectionNotFoundError]
    def self.get_direction(name)
      case name
      when :NORTH
        Direction.new(:NORTH, 0, 1)
      when :WEST
        Direction.new(:WEST, -1, 0)
      when :SOUTH
        Direction.new(:SOUTH, 0, -1)
      when :EAST
        Direction.new(:EAST, 1, 0)
      else
        raise DirectionNotFoundError, 'direction cannot be found by the given name'
      end
    end

    # @param  [Symbol] name
    # @return [Fixnum]
    # @raise  [DirectionValueNotFound]
    def self.find_value(name)
      value = DIRECTIONS[name]
      value.nil? ? (raise DirectionValueNotFoundError, 'direction value cannot be found by the given name') : value
    end

    # @param  [Symbol] name
    # @return [Direction]
    # @raise  [ArgumentError]
    def self.get_left_direction(name)
      raise ArgumentError, 'argument is expected to a symbol' unless name.is_a?(Symbol)

      value = find_value(name)
      name = INVERTED_DIRECTIONS[(value + 1) % INVERTED_DIRECTIONS.size]
      get_direction(name)
    end

    # @param  [Direction] name
    # @return [Direction]
    # @raise  [ArgumentError]
    def self.get_right_direction(name)
      raise ArgumentError, 'argument is expected to a symbol' unless name.is_a?(Symbol)

      value = find_value(name)
      value += DIRECTIONS.size if value <= 0
      name = INVERTED_DIRECTIONS[value - 1]
      get_direction(name)
    end
  end
end
