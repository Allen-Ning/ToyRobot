# frozen_string_literal: true

require 'ffaker'

require_relative '../lib/simulator/command_processor'
require_relative '../lib/model/robot'

module ToyRobot
  describe CommandProcessor do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let(:command_processor) { CommandProcessor.new(robot, board) }

    subject { command_processor.process_command(command) }

    context 'should process command' do
      context 'a' do
        let(:command) { 'PLACE 2,3,NORTH' }

        it 'should invoke set position method' do
          expect(robot).to receive(:place).with(:NORTH, 2, 3)

          subject
        end
      end

      context 'b' do
        let(:command) { 'LEFT' }

        it 'should invoke turn left method' do
          expect(robot).to receive(:turn_left)

          subject
        end
      end

      context 'c' do
        let(:command) { 'RIGHT' }

        it 'should invoke turn right method' do
          expect(robot).to receive(:turn_right)

          subject
        end
      end

      context 'd' do
        let(:command) { 'MOVE' }
        it 'should invoke move method' do
          expect(robot).to receive(:move)

          subject
        end
      end

      context 'e' do
        let(:command) { 'REPORT' }

        it 'should invoke report method' do
          expect(robot).to receive(:report)

          subject
        end
      end

      context 'f' do
        let(:command) { '' }

        it 'should ignore blank lines' do
          expect(subject).to be_nil
        end
      end

      context 'g' do
        let(:command) { 'INVALID_COMMAND' }

        it 'should raise CommandParseError for invalid commands' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end

      context 'h' do
        let(:command) { 'PLACE 2,3,4,NORTH' }

        it 'should raise CommandParseError for PLACE commands which have not 3 parameters' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end

      context 'i' do
        let(:command) { 'PLACE one,two,NORTH' }

        it 'should raise CommandParseError for PLACE commands with wrong type coordinates' do
          expect { subject }.to raise_error(CommandParseError)
        end
      end
    end
  end
end
