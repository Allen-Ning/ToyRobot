require_relative '../entity/robot'
require_relative '../entity/board'
require_relative '../simulator/command_processor'

module ToyRobot
  class RobotRunner

    # @param [Robot] robot
    # @param [Board] board
    def initialize(robot = Robot.new, board = Board.new)
      @command_processor = CommandProcessor.new(robot, board)
    end

    # @param  [Array] data
    # @return [Void]
    def pretty_print(data)
      output = data.inject('') {|total, each| total + each.to_s + ' ' }
      puts output unless output.strip.size. == 0
    end

    # @return [void]
    def run
      ARGF.each do |command|
        data = @command_processor.process_command(command)
        pretty_print(data) if data.is_a?(Array)
      end
    end
  end
end