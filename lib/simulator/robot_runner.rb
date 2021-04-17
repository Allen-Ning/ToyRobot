# frozen_string_literal: true

require 'model/robot'
require 'model/board'
require 'simulator/command_processor'

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
      output = data.inject('') { |total, each| "#{total}#{each} " }
      puts output unless output.strip.size.zero?
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
