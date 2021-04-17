# frozen_string_literal: true

require 'error/invalid_board_width_error'
require 'error/invalid_board_height_error'

module ToyRobot
  class Board
    attr_reader :width, :height

    # @param [Fixnum] width
    # @param [Fixnum] height
    def initialize(width: 5, height: 5)
      raise InvalidBoardWidthError, 'board width is invalid - equal or less than 0' if width <= 0
      raise InvalidBoardHeightError, 'board height is invalid - equal or less than 0' if height <= 0

      @width  = width
      @height = height
    end
  end
end
