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

    # @param  [String] raw_command
    # @return [Boolean]
    # @raise CommandParseError
    def process_command(raw_command)
      command_name, command_params = parse_command(raw_command)
      case command_name
      when 'PLACE'
        direction, x, y = place_command_parameters(command_params)
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
        raise CommandParseError, "unrecognized command - #{raw_command}"
      end
    end

    private

    # @param  [String] raw_command
    # @return [Array]
    def parse_command(raw_command)
      command_match = raw_command.split(/\s+/).map(&:strip)
      return [nil, nil] if command_match.size.zero?

      command_name = command_match[0]
      command_params = command_match[1]
      [command_name, command_params]
    end

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
