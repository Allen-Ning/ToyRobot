require 'spec_helper'

module ToyRobot
  describe Robot do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let(:direction_north) { Direction.get_direction(Direction::NORTH) }
    let(:direction_west) { Direction.get_direction(Direction::WEST) }
    let(:direction_south) { Direction.get_direction(Direction::SOUTH) }
    let(:direction_east) { Direction.get_direction(Direction::EAST) }

    let(:random) {Random.new}
    let(:coordinate) { Coordinate.new(random.rand(1..board.width - 1), random.rand(1..board.height - 1)) }
    let(:invalid_x_coordinate) { Coordinate.new(random.rand(board.width + 1..Random.new_seed), random.rand(0..board.height)) }
    let(:invalid_y_coordinate) { Coordinate.new(random.rand(0..board.width), random.rand(board.height + 1..Random.new_seed)) }
    let(:invalid_xy_coordinate) { Coordinate.new(random.rand(board.width + 1..Random.new_seed), random.rand(board.height + 1..Random.new_seed)) }

    context 'set robot position' do
      it 'set valid robot position' do
        expect(robot.set_position(board, coordinate, direction_north)).to be_true
      end

      it 'set invalid robot position - x coordinate larger than the width of board' do
        expect(robot.set_position(board, invalid_x_coordinate, direction_north)).to be_false
      end

      it 'set invalid robot position - y coordinate larger than the height of board' do
        expect(robot.set_position(board, invalid_y_coordinate, direction_north)).to be_false
      end

      it 'set invalid robot position - x, y coordinates larger than the width and height of board' do
        expect(robot.set_position(board, invalid_xy_coordinate, direction_north)).to be_false
      end
    end

    context 'turn left' do
      it 'turn left when robot is facing NORTH' do
        robot.set_position(board, coordinate, direction_north)
        expect(robot.turn_left).to be_true
        expect(robot.direction.get_name).to eql(Direction::WEST)
      end

      it 'turn left when robot is facing WEST' do
        robot.set_position(board, coordinate, direction_west)
        expect(robot.turn_left).to be_true
        expect(robot.direction.get_name).to eql(Direction::SOUTH)
      end

      it 'turn left when robot is facing SOUTH' do
        robot.set_position(board, coordinate, direction_south)
        expect(robot.turn_left).to be_true
        expect(robot.direction.get_name).to eql(Direction::EAST)
      end

      it 'turn left when robot is facing EAST' do
        robot.set_position(board, coordinate, direction_east)
        expect(robot.turn_left).to be_true
        expect(robot.direction.get_name).to eql(Direction::NORTH)
      end

      it 'turn left when robot is not board - x coordinate larger than the width of board' do
        robot.set_position(board, invalid_x_coordinate, direction_north)
        expect(robot.turn_left).to be_false
      end

      it 'turn left when robot is not board - y coordinate larger than the height of board' do
        robot.set_position(board, invalid_y_coordinate, direction_north)
        expect(robot.turn_left).to be_false
      end

      it 'turn left when robot is not board - x, y coordinates larger than the width and height of board' do
        robot.set_position(board, invalid_xy_coordinate, direction_north)
        expect(robot.turn_left).to be_false
      end
    end

    context 'turn right' do
      it 'turn right when robot is facing NORTH' do
        robot.set_position(board, coordinate, direction_north)
        expect(robot.turn_right).to be_true
        expect(robot.direction.get_name).to eql(Direction::EAST)
      end

      it 'turn right when robot is facing WEST' do
        robot.set_position(board, coordinate, direction_west)
        expect(robot.turn_right).to be_true
        expect(robot.direction.get_name).to eql(Direction::NORTH)
      end

      it 'turn right when robot is facing SOUTH' do
        robot.set_position(board, coordinate, direction_south)
        expect(robot.turn_right).to be_true
        expect(robot.direction.get_name).to eql(Direction::WEST)
      end

      it 'turn right when robot is facing EAST' do
        robot.set_position(board, coordinate, direction_east)
        expect(robot.turn_right).to be_true
        expect(robot.direction.get_name).to eql(Direction::SOUTH)
      end

      it 'turn right when robot is not board - x coordinate larger than the width of board' do
        robot.set_position(board, invalid_x_coordinate, direction_north)
        expect(robot.turn_right).to be_false
      end

      it 'turn right when robot is not board - y coordinate larger than the height of board' do
        robot.set_position(board, invalid_y_coordinate, direction_north)
        expect(robot.turn_right).to be_false
      end

      it 'turn right when robot is not board - x, y coordinates larger than the width and height of board' do
        robot.set_position(board, invalid_xy_coordinate, direction_north)
        expect(robot.turn_right).to be_false
      end
    end

    context 'move' do
      it 'move when facing NORTH' do
        robot.set_position(board, coordinate, direction_north)
        robot.move
        expect(robot.direction.get_name).to eql(Direction::NORTH)
        expect(robot.current_coordinate.x).to eql(coordinate.x)
        expect(robot.current_coordinate.y).to eql(coordinate.y + 1)
      end

      it 'move when facing WEST' do
        robot.set_position(board, coordinate, direction_west)
        robot.move
        expect(robot.direction.get_name).to eql(Direction::WEST)
        expect(robot.current_coordinate.x).to eql(coordinate.x - 1)
        expect(robot.current_coordinate.y).to eql(coordinate.y)
      end

      it 'move when facing SOUTH' do
        robot.set_position(board, coordinate, direction_south)
        robot.move
        expect(robot.direction.get_name).to eql(Direction::SOUTH)
        expect(robot.current_coordinate.x).to eql(coordinate.x)
        expect(robot.current_coordinate.y).to eql(coordinate.y - 1)
      end

      it 'move when facing EAST' do
        robot.set_position(board, coordinate, direction_east)
        robot.move
        expect(robot.direction.get_name).to eql(Direction::EAST)
        expect(robot.current_coordinate.x).to eql(coordinate.x + 1)
        expect(robot.current_coordinate.y).to eql(coordinate.y)
      end

      it 'move when not on board' do
        expect(robot.move).to be_false
      end
    end

    context 'report' do
      it 'report when facing NORTH on board' do
        robot.set_position(board, coordinate, direction_north)
        expect(robot.report).to eql([coordinate.x, coordinate.y, direction_north.get_name])
      end

      it 'report when facing WEST on board' do
        robot.set_position(board, coordinate, direction_west)
        expect(robot.report).to eql([coordinate.x, coordinate.y, direction_west.get_name])
      end

      it 'report when facing SOUTH on board' do
        robot.set_position(board, coordinate, direction_south)
        expect(robot.report).to eql([coordinate.x, coordinate.y, direction_south.get_name])
      end

      it 'report when on facing EAST on board' do
        robot.set_position(board, coordinate, direction_east)
        expect(robot.report).to eql([coordinate.x, coordinate.y, direction_east.get_name])
      end

      it 'report when not on board' do
        expect(robot.report).to eql([])
      end
    end
  end
end