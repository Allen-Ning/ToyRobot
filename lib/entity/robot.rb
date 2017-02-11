require_relative '../entity/direction'

module ToyRobot
  class Robot
    attr_reader :board, :current_coordinate, :direction

    # @param  {Board} board
    # @return {void}
    def set_board(board)
      @board = board
    end

    # @param  {Symbol}  direction_name
    # @param  {Integer} x
    # @param  {Integer} y
    # @return {Boolean}
    def place(direction_name, x, y)
      if is_coordinate_on_table?(x, y)
        @direction = Direction.get_direction(direction_name)
        set_coordinate(Coordinate.new(x, y))
        true
      else
        false
      end
    end

    # @return {Boolean}
    def turn_left
      if is_on_board?
        @direction = Direction.get_left_direction(@direction.name)
        true
      else
        false
      end
    end

    # @return {Boolean}
    def turn_right
      if is_on_board?
        @direction = Direction.get_right_direction(@direction.name)
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
      is_on_board? ? [ @direction.name, @current_coordinate.x, @current_coordinate.y] : []
    end

    # @param  {Integer} x
    # @param  {Integer} y
    # @return {Boolean}
    def is_coordinate_on_table?(x, y)
      (!@board.nil? && x <= @board.width && y <= @board.height) ? true : false
    end

    # @param  {Coordinate} coordinate
    # @return {Void}
    def set_coordinate(coordinate)
      @current_coordinate.nil? ? @current_coordinate = coordinate.clone : @current_coordinate.add_coordinate(coordinate)
    end

    # @return {Boolean}
    def is_on_board?
      !@board.nil? && !@current_coordinate.nil? && !@direction.nil?
    end

    # @return {Boolean}
    def can_move?
      if is_on_board?
        coordinate = @direction.coordinate
        if @current_coordinate.x + coordinate.x >= 0 &&
           @current_coordinate.x + coordinate.x <= @board.width &&
           @current_coordinate.y + coordinate.y >= 0 &&
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
