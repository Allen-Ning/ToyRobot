# frozen_string_literal: true

require_relative '../exception/invalid_board_width_exception'
require_relative '../exception/invalid_board_height_exception'

module ToyRobot
  class Board
    attr_reader :width, :height

    # @param [Fixnum] width
    # @param [Fixnum] height
    def initialize(width = 5, height = 5)
      raise InvalidBoardWidthException, 'board width is invalid - equal or less than 0' if width <= 0
      raise InvalidBoardHeightException, 'board height is invalid - equal or less than 0' if height <= 0

      @width  = width
      @height = height
    end
  end
end
