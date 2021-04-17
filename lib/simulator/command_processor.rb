# frozen_string_literal: true

require 'error/command_parse_error'
require 'model/coordinate'
require 'model/direction'

module ToyRobot
  class CommandProcessor
    # @param [Robot] robot
    # @param [Board] board
    def initialize(robot, board)
      robot.set_board(board)
      @robot = robot
    end

    # @param  [String]   raw_command
    # @return [Array,nil]
    # @raise CommandParseError
    def process_command(raw_command)
      command_match = raw_command.split(' ').map(&:strip)
      return if command_match.size.zero?

      case command_match[0]
      when 'PLACE'
        direction, x, y = get_place_command_parameters(command_match[1])
        @robot.place(direction, x, y)
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

    # @param  [String] params_str
    # @return [Array]
    # @raise  [CommandParseError]
    def get_place_command_parameters(params_str)
      params = params_str.split(',').map(&:strip)
      raise CommandParseError, 'place command must contain x,y,direction' unless params.size == 3

      x, y = get_coordinates(params)
      direction = get_direction_name(params)
      [direction, x, y]
    end

    # @param  [String[]]  params
    # @return [Fixnum[]]
    # @raise  [CommandParseError]
    def get_coordinates(params)
      x = Integer(params[0])
      y = Integer(params[1])
      [x, y]
    rescue ArgumentError
      raise CommandParseError, 'place coordinates must be Fixnum'
    end

    # @param [String[]]
    # @param [Symbol]
    def get_direction_name(params)
      params[2].to_sym
    end

    private :get_place_command_parameters, :get_coordinates, :get_direction_name
  end
end
