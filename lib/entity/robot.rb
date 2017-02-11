require_relative '../entity/direction'

module ToyRobot
  class Robot
    attr_reader :board, :current_coordinate, :direction

    # @param {Board} board
    # @param {Coordinate} coordinate
    # @param {direction} direction
    # @return {Boolean}
    def set_position(board, coordinate, direction)
      if is_coordinate_on_table?(board, coordinate)
        @board     = board
        @direction = direction
        set_coordinate(coordinate)
        true
      else
        false
      end
    end

    # @return {Boolean}
    def turn_left
      if is_on_board?
        @direction = Direction.get_left_direction(@direction)
        true
      else
        false
      end
    end

    # @return {Boolean}
    def turn_right
      if is_on_board?
        @direction = Direction.get_right_direction(@direction)
        true
      else
        false
      end
    end

    # @return {Boolean}
    def move
      if can_move?
        set_coordinate(@direction.coordinate)
        true
      else
        false
      end
    end

    # @return {Array}
    def report
      is_on_board? ? [@current_coordinate.x, @current_coordinate.y, @direction.get_name] : []
    end

    # @param  {Board} board
    # @return {Boolean}
    def is_coordinate_on_table?(board, coordinate)
      (coordinate.x <= board.width and coordinate.y <= board.height) ? true : false
    end

    # @param  {Coordinate} coordinate
    # @return {Void}
    def set_coordinate(coordinate)
      @current_coordinate.nil? ? @current_coordinate = coordinate.clone : @current_coordinate.add_coordinate(coordinate)
    end

    # @return {Boolean}
    def is_on_board?
      !@board.nil? and !@current_coordinate.nil? and !@direction.nil?
    end

    # @return {Boolean}
    def can_move?
      if is_on_board?
        coordinate = @direction.coordinate
        if @current_coordinate.x + coordinate.x >= 0 and
           @current_coordinate.x + coordinate.x <= @board.width and
           @current_coordinate.y + coordinate.y >= 0 and
           @current_coordinate.y + coordinate.y <= @board.height
          true
        else
          false
        end
      else
        false
      end
    end

    private :is_coordinate_on_table?, :set_coordinate, :is_on_board?, :can_move?
  end
end
