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

    # @param  {Board} board
    # @return {Boolean}
    def is_coordinate_on_table?(board, coordinate)
      (coordinate.x <= board.width and coordinate.y <= board.height) ? true : false
    end

    # @param  {Coordinate} coordinate
    # @return {Void}
    def set_coordinate(coordinate)
      @current_coordinate.nil? ? @current_coordinate = coordinate : @current_coordinate.add_coordinate(coordinate)
    end

    private :is_coordinate_on_table?, :set_coordinate
  end
end
