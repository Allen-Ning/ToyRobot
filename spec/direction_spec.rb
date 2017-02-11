require 'spec_helper'

module ToyRobot
  describe Direction do
    context 'create direction instance' do
      it 'create invalid direction instance' do
        random = Random.new
        index  = random.rand(Direction::DIRECTIONS.size + 1..Random.new_seed)
        expect { Direction.new(index,
                               random.rand(-Random.new_seed..Random.new_seed),
                               random.rand(-Random.new_seed..Random.new_seed))
               }.to raise_error DirectionInvalidValueException
      end
    end

    context 'get direction name' do
      it 'get NORTH direction name' do
        index     = Direction::DIRECTIONS.index(Direction::NORTH)
        direction = Direction.new(index, 0, 1)
        expect(direction.get_name).to eql(Direction::NORTH)
      end

      it 'get WEST direction name' do
        index     = Direction::DIRECTIONS.index(Direction::WEST)
        direction = Direction.new(index, -1, 0)
        expect(direction.get_name).to eql(Direction::WEST)
      end

      it 'get SOUTH direction name' do
        index     = Direction::DIRECTIONS.index(Direction::SOUTH)
        direction = Direction.new(index, 0, -1)
        expect(direction.get_name).to eql(Direction::SOUTH)
      end

      it 'get WEST direction name' do
        index     = Direction::DIRECTIONS.index(Direction::WEST)
        direction = Direction.new(index, 1, 0)
        expect(direction.get_name).to eql(Direction::WEST)
      end
    end

    context 'find index' do
      it 'find NORTH direction index' do
        index = Direction.find_index(Direction::NORTH)
        expect(index).to eql(0)
      end

      it 'find WEST direction index' do
        index = Direction.find_index(Direction::WEST)
        expect(index).to eql(1)
      end

      it 'find SOUTH direction index' do
        index = Direction.find_index(Direction::SOUTH)
        expect(index).to eql(2)
      end

      it 'find EAST direction index' do
        index = Direction.find_index(Direction::EAST)
        expect(index).to eql(3)
      end

      it 'find direction index using invalid direction name' do
        expect { Direction.find_index(:INVALID_DIRECTION) }.to raise_error DirectionNameNotFoundException
      end
    end

    context 'get direction' do
      it 'get NORTH direction' do
        direction = Direction.get_direction(Direction::NORTH)
        expect(direction.get_name).to eql(Direction::NORTH)
        expect(direction.coordinate.x).to eql(0)
        expect(direction.coordinate.y).to eql(1)
      end

      it 'get WEST direction' do
        direction = Direction.get_direction(Direction::WEST)
        expect(direction.get_name).to eql(Direction::WEST)
        expect(direction.coordinate.x).to eql(-1)
        expect(direction.coordinate.y).to eql(0)
      end

      it 'get SOUTH direction' do
        direction = Direction.get_direction(Direction::SOUTH)
        expect(direction.get_name).to eql(Direction::SOUTH)
        expect(direction.coordinate.x).to eql(0)
        expect(direction.coordinate.y).to eql(-1)
      end

      it 'get EAST direction' do
        direction = Direction.get_direction(Direction::EAST)
        expect(direction.get_name).to eql(Direction::EAST)
        expect(direction.coordinate.x).to eql(1)
        expect(direction.coordinate.y).to eql(0)
      end

      it 'get invalid direction' do
        expect { Direction.get_direction(:INVALID_DIRECTION) }.to raise_error DirectionNotFoundException
      end
    end

    context 'get valid left direction' do
      it 'get left direction of NORTH direction' do
        direction      = Direction.get_direction(Direction::NORTH)
        left_direction = Direction.get_left_direction(direction)
        expect(left_direction.get_name).to eql(Direction::WEST)
        expect(left_direction.coordinate.x).to eql(-1)
        expect(left_direction.coordinate.y).to eql(0)
      end

      it 'get left direction of WEST direction' do
        direction      = Direction.get_direction(Direction::WEST)
        left_direction = Direction.get_left_direction(direction)
        expect(left_direction.get_name).to eql(Direction::SOUTH)
        expect(left_direction.coordinate.x).to eql(0)
        expect(left_direction.coordinate.y).to eql(-1)
      end

      it 'get left direction of SOUTH direction' do
        direction      = Direction.get_direction(Direction::SOUTH)
        left_direction = Direction.get_left_direction(direction)
        expect(left_direction.get_name).to eql(Direction::EAST)
        expect(left_direction.coordinate.x).to eql(1)
        expect(left_direction.coordinate.y).to eql(0)
      end

      it 'get left direction of EAST direction' do
        direction      = Direction.get_direction(Direction::EAST)
        left_direction = Direction.get_left_direction(direction)
        expect(left_direction.get_name).to eql(Direction::NORTH)
        expect(left_direction.coordinate.x).to eql(0)
        expect(left_direction.coordinate.y).to eql(1)
      end
    end

    context 'get valid right direction' do
      it 'get right direction of NORTH direction' do
        direction       = Direction.get_direction(Direction::NORTH)
        right_direction = Direction.get_right_direction(direction)
        expect(right_direction.get_name).to eql(Direction::EAST)
        expect(right_direction.coordinate.x).to eql(1)
        expect(right_direction.coordinate.y).to eql(0)
      end

      it 'get right direction of WEST direction' do
        direction       = Direction.get_direction(Direction::WEST)
        right_direction = Direction.get_right_direction(direction)
        expect(right_direction.get_name).to eql(Direction::NORTH)
        expect(right_direction.coordinate.x).to eql(0)
        expect(right_direction.coordinate.y).to eql(1)
      end

      it 'get right direction of SOUTH direction' do
        direction       = Direction.get_direction(Direction::SOUTH)
        right_direction = Direction.get_right_direction(direction)
        expect(right_direction.get_name).to eql(Direction::WEST)
        expect(right_direction.coordinate.x).to eql(-1)
        expect(right_direction.coordinate.y).to eql(0)
      end

      it 'get right direction of EAST direction' do
        direction       = Direction.get_direction(Direction::EAST)
        right_direction = Direction.get_right_direction(direction)
        expect(right_direction.get_name).to eql(Direction::SOUTH)
        expect(right_direction.coordinate.x).to eql(0)
        expect(right_direction.coordinate.y).to eql(-1)
      end
    end

    context 'get left or right direction of an invalid direction' do
      it 'get left direction of an invalid direction' do
        expect { Direction.get_left_direction(:INVALID_DIRECTION) }.to raise_error ArgumentError
      end

      it 'get right direction of an invalid direction' do
        expect { Direction.get_right_direction(:INVALID_DIRECTION) }.to raise_error ArgumentError

      end
    end
  end
end