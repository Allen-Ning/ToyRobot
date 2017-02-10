module ToyRobot
  class Direction
    attr_reader :value, :coordinate

    NORTH = :north
    SOUTH = :south
    EAST  = :east
    WEST  = :west
    DIRECTIONS = [Direction::NORTH, Direction::WEST, Direction::SOUTH, Direction::EAST].freeze
    DIRECTION_INVALID_VALUE  = 'direction value is invalid'
    DIRECTION_NOT_FOUND      = 'direction cannot be found by the given name'
    DIRECTION_NAME_NOT_FOUND = 'direction name cannot be found by the given value'

    # @param {Integer} value
    # @param {Integer} x
    # @param {Integer} y
    # @raise {DirectionInvalidValueException}
    def initialize(value, x, y)
      raise DirectionInvalidValueException, DIRECTION_INVALID_VALUE if value < 0 or value > DIRECTIONS.size - 1

      @value      = value
      @coordinate = Coordinate.new(x, y)
    end

    # @return {Symbol}
    def get_name
      DIRECTIONS[@value]
    end

    # @param  {String} name
    # @return {Direction}
    # @raise  {DirectionNotFoundException}
    def self.get_direction(name)
      case name
        when Direction::NORTH
          Direction.new(DIRECTIONS.index(Direction::NORTH), 0, 1)
        when Direction::WEST
          Direction.new(DIRECTIONS.index(Direction::WEST), -1, 0)
        when Direction::SOUTH
          Direction.new(DIRECTIONS.index(Direction::SOUTH), 0, -1)
        when Direction::EAST
          Direction.new(DIRECTIONS.index(Direction::EAST), 1, 0)
        else
          raise DirectionNotFoundException, DIRECTION_NOT_FOUND
      end
    end

    # @param  {Symbol} name
    # @return {Integer}
    # @raise  {DirectionNameNotFoundException}
    def self.find_index(name)
      index = DIRECTIONS.index(name)
      index.nil? ? (raise DirectionNameNotFoundException, DIRECTION_NOT_FOUND) : index
    end
  end
end