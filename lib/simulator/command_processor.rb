require_relative '../exception/command_parse_exception'
require_relative '../entity/coordinate'
require_relative '../entity/direction'

module ToyRobot
  class CommandProcessor

    # @param {Robot} robot
    # @param {Board} board
    def initialize(robot, board)
      robot.set_board(board)
      @robot = robot
    end

    # @param  {String}   raw_command
    # @return {Array|nil}
    # @raise CommandParseException
    def process_command(raw_command)
      command_match = raw_command.split(' ').map(&:strip)
      return if command_match.size == 0
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
          raise CommandParseException, 'unrecognized command - ' + command_match[0]
      end
    end

    # @param  {String} params_str
    # @return {Array}
    # @raise  {CommandParseException}
    def get_place_command_parameters(params_str)
      params = params_str.split(',').map(&:strip)
      raise CommandParseException, 'place command must contain x,y,direction' unless params.size == 3
      x, y = get_coordinates(params)
      direction = get_direction_name(params)
      return direction, x, y
    end

    # @param  {String[]} params
    # @return {Integer[]}
    # @raise  {CommandParseException}
    def get_coordinates(params)
      x = Integer(params[0])
      y = Integer(params[1])
      return x, y
    rescue ArgumentError
      raise CommandParseException, 'place coordinates must be integers'
    end

    # @param {String[]}
    # @param {Symbol}
    def get_direction_name(params)
      params[2].to_sym
    end

    private :get_place_command_parameters, :get_coordinates, :get_direction_name
  end
end