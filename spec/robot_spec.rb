require 'spec_helper'

module ToyRobot
  describe Robot do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let(:direction) { Direction.get_direction(Direction::NORTH) }
    let(:coordinate) { Coordinate.new(0, 0) }
    let(:random) {Random.new}

    context 'set robot position' do
      it 'set valid robot position' do
        expect(robot.set_position(board, coordinate, direction)).to be_true
      end

      it 'set invalid robot position - x coordinate larger than the width of board' do
        coordinate  = Coordinate.new(random.rand(board.width + 1..Random.new_seed), random.rand(0..board.height))
        expect(robot.set_position(board, coordinate, direction)).to be_false
      end

      it 'set invalid robot position - y coordinate larger than the height of board' do
        coordinate = Coordinate.new(random.rand(0..board.width), random.rand(board.height + 1..Random.new_seed))
        expect(robot.set_position(board, coordinate, direction)).to be_false
      end

      it 'set invalid robot position - x, y coordinate larger than the width and height of board' do
        coordinate = Coordinate.new(random.rand(board.width + 1..Random.new_seed), random.rand(board.height + 1..Random.new_seed))
        expect(robot.set_position(board, coordinate, direction)).to be_false
      end
    end
  end
end