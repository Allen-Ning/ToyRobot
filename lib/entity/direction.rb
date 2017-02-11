require_relative '../exception/direction_invalid_value_exception'
require_relative '../exception/direction_not_found_exception'
require_relative '../exception/direction_name_not_found_exception'
require_relative '../exception/direction_value_not_found_exception'

module ToyRobot
  class Direction
    attr_reader :name, :coordinate

    DIRECTIONS = { :NORTH => 0, :WEST => 1, :SOUTH => 2, :EAST => 3 }
    INVERT_DIRECTIONS = DIRECTIONS.invert

    # @param [:Symbol] name
    # @param [Integer] x
    # @param [Integer] y
    # @raise [DirectionInvalidValueException]
    def initialize(name, x, y)
      raise DirectionInvalidValueException, 'direction value is invalid' unless DIRECTIONS.has_key? name
      @name = name
      @coordinate = Coordinate.new(x, y)
    end

    # @param  [Symbol] name
    # @return [Direction]
    # @raise  [DirectionNotFoundException]
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
          raise DirectionNotFoundException, 'direction cannot be found by the given name'
      end
    end

    # @param  [Symbol] name
    # @return [Integer]
    # @raise  [DirectionValueNotFound]
    def self.find_value(name)
      value = DIRECTIONS[name]
      value.nil? ? (raise DirectionValueNotFoundException, 'direction value cannot be found by the given name') : value
    end

    # @param  [Symbol] name
    # @return [Direction]
    # @raise  [ArgumentError]
    def self.get_left_direction(name)
      if name.is_a?(Symbol)
        value = find_value(name)
        name = INVERT_DIRECTIONS[(value + 1) % INVERT_DIRECTIONS.size]
        get_direction(name)
      else
        raise ArgumentError, 'argument is expected to a symbol'
      end
    end

    # @param  [Direction] name
    # @return [Direction]
    # @raise  [ArgumentError]
    def self.get_right_direction(name)
      if name.is_a?(Symbol)
        value = find_value(name)
        value += DIRECTIONS.size if value <= 0
        name = INVERT_DIRECTIONS[value - 1]
        get_direction(name)
      else
        raise ArgumentError, 'argument is expected to a symbol'
      end
    end
  end
end