# frozen_string_literal: true

require 'error/command_parse_error'
require 'model/coordinate'
require 'model/direction'

module ToyRobot
  class CommandProcessor
    # @param [Robot] robot
    # @param [Board] board
    def initialize(robot:, board:)
      @robot = robot
      @board = board
    end

    # @param  [String]   raw_command
    # @return [Array,nil]
    # @raise CommandParseError
    def process_command(raw_command)
      # multiple space
      command_match = raw_command.split(' ').map(&:strip)
      return if command_match.size.zero?

      case command_match[0]
      when 'PLACE'
        direction, x, y = place_command_parameters(command_match[1])
        @robot.place(board: @board, direction_name: direction, x: x, y: y)
      when 'LEFT'
        @robot.turn_left
      when 'RIGHT'
        @robot.turn_right
      when 'MOVE'
        @robot.move
      when 'REPORT'
        @robot.report
      else
        raise CommandParseError, "unrecognized command - #{command_match[0]}"
      end
    end

    private

    # @param  [String] params_str
    # @return [Array]
    # @raise  [CommandParseError]
    def place_command_parameters(params_str)
      params = params_str.split(',').map(&:strip)
      raise CommandParseError, 'place command must contain x,y,direction' unless params.size == 3

      x, y = coordinates(params)
      direction = direction_name(params)
      [direction, x, y]
    end

    # @param  [String[]]  params
    # @return [Fixnum[]]
    # @raise  [CommandParseError]
    def coordinates(params)
      x = Integer(params[0])
      y = Integer(params[1])
      [x, y]
    rescue ArgumentError
      raise CommandParseError, 'place coordinates must be Fixnum'
    end

    # @param [String[]]
    # @param [Symbol]
    def direction_name(params)
      params[2].to_sym
    end
  end
end
