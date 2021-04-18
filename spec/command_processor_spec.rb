# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe CommandProcessor do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let(:command_processor) { CommandProcessor.new(robot: robot, board: board) }

    subject { command_processor.process_command(command) }

    describe '#process_command' do
      context 'when PLACE command is processed' do
        let(:x) { FFaker::Random.rand(0..board.width - 1) }
        let(:y) { FFaker::Random.rand(0..board.height - 1) }
        let(:command) { "PLACE #{x},#{y},NORTH" }

        it 'invokes set position method' do
          expect(robot).to receive(:place).with(board: board, direction_name: :NORTH, x: x, y: y)

          subject
        end
      end

      context 'when a LEFT command is processed' do
        let(:command) { 'LEFT' }

        it 'invokes turn left method' do
          expect(robot).to receive(:turn_left)

          subject
        end
      end

      context 'when a RIGHT command is processed' do
        let(:command) { 'RIGHT' }

        it 'invokes turn right method' do
          expect(robot).to receive(:turn_right)

          subject
        end
      end

      context 'when a MOVE command is processed' do
        let(:command) { 'MOVE' }

        it 'invokes move method' do
          expect(robot).to receive(:move)

          subject
        end
      end

      context 'when a REPORT command is processed' do
        let(:command) { 'REPORT' }

        it 'invokes report method' do
          expect(robot).to receive(:report)

          subject
        end
      end

      context 'when no command is not given' do
        let(:command) { '' }

        it 'raises CommandParseError' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end

      context 'when an invalid command is given' do
        let(:command) { 'INVALID_COMMAND' }

        it 'raises CommandParseError for invalid commands' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end

      context 'when a command with too many params is given' do
        let(:command) { 'PLACE 2,3,4,NORTH' }

        it 'raises CommandParseError for PLACE commands which have not 3 parameters' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end

      context 'when a command with wrong params is given' do
        let(:command) { 'PLACE one,two,NORTH' }

        it 'raises CommandParseError for PLACE commands with wrong type coordinates' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end
    end
  end
end
