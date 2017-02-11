require_relative '../lib/simulator/command_processor'
require_relative '../lib/entity/robot'

module ToyRobot
  describe CommandProcessor do
    let(:random) { Random.new }
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let(:command_processor) { CommandProcessor.new(robot, board) }

    context 'should process command' do
      it 'should invoke set position method' do
        expect(robot).to receive(:set_position)
        command_processor.process_command('PLACE 2,3,NORTH')
      end

      it 'should invoke turn left method' do
        expect(robot).to receive(:turn_left)
        command_processor.process_command('LEFT')
      end

      it 'should invoke turn right method' do
        expect(robot).to receive(:turn_right)
        command_processor.process_command('RIGHT')
      end

      it 'should invoke move method' do
        expect(robot).to receive(:move)
        command_processor.process_command('MOVE')
      end

      it 'should invoke report method' do
        expect(robot).to receive(:report)
        command_processor.process_command('REPORT')
      end

      it 'should ignore blank lines' do
        expect(command_processor.process_command('')).to be_nil
      end

      it 'should raise CommandParseException for invalid commands' do
        expect{ command_processor.process_command('INVALID_COMMAND') }.to raise_error(CommandParseException)
      end

      it 'should raise CommandParseException for PLACE commands which have not 3 parameters' do
        expect{ command_processor.process_command('PLACE 2,3,4,NORTH') }.to raise_error(CommandParseException)
      end

      it 'should raise CommandParseException for PLACE commands with wrong type coordinates' do
        expect{ command_processor.process_command('PLACE one,two,NORTH') }.to raise_error(CommandParseException)
      end
    end
  end
end