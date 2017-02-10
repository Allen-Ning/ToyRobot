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
      it 'get north direction name' do
        index     = Direction::DIRECTIONS.index(Direction::NORTH)
        direction = Direction.new(index, 0, 1)
        expect(direction.get_name).to eql(Direction::NORTH)
      end

      it 'get west direction name' do
        index     = Direction::DIRECTIONS.index(Direction::WEST)
        direction = Direction.new(index, -1, 0)
        expect(direction.get_name).to eql(Direction::WEST)
      end

      it 'get south direction name' do
        index     = Direction::DIRECTIONS.index(Direction::SOUTH)
        direction = Direction.new(index, 0, -1)
        expect(direction.get_name).to eql(Direction::SOUTH)
      end

      it 'get west direction name' do
        index     = Direction::DIRECTIONS.index(Direction::WEST)
        direction = Direction.new(index, 1, 0)
        expect(direction.get_name).to eql(Direction::WEST)
      end
    end

    context 'find index' do
      it 'find north direction index' do
        index = Direction.find_index(Direction::NORTH)
        expect(index).to eql(0)
      end

      it 'find north direction index' do
        index = Direction.find_index(Direction::WEST)
        expect(index).to eql(1)
      end

      it 'find north direction index' do
        index = Direction.find_index(Direction::SOUTH)
        expect(index).to eql(2)
      end

      it 'find north direction index' do
        index = Direction.find_index(Direction::EAST)
        expect(index).to eql(3)
      end

      it 'find direction index using invalid direction name' do
        expect { Direction.find_index(:INVALID_DIRECTION) }.to raise_error DirectionNameNotFoundException
      end
    end

    context 'get direction' do
      it 'get north direction' do
        direction = Direction.get_direction(Direction::NORTH)
        expect(direction.get_name).to eql(Direction::NORTH)
        expect(direction.coordinate.x).to eql(0)
        expect(direction.coordinate.y).to eql(1)
      end

      it 'get west direction' do
        direction = Direction.get_direction(Direction::WEST)
        expect(direction.get_name).to eql(Direction::WEST)
        expect(direction.coordinate.x).to eql(-1)
        expect(direction.coordinate.y).to eql(0)
      end

      it 'get south direction' do
        direction = Direction.get_direction(Direction::SOUTH)
        expect(direction.get_name).to eql(Direction::SOUTH)
        expect(direction.coordinate.x).to eql(0)
        expect(direction.coordinate.y).to eql(-1)
      end

      it 'get east direction' do
        direction = Direction.get_direction(Direction::EAST)
        expect(direction.get_name).to eql(Direction::EAST)
        expect(direction.coordinate.x).to eql(1)
        expect(direction.coordinate.y).to eql(0)
      end

      it 'get invalid direction' do
        expect { Direction.get_direction(:INVALID_DIRECTION_NAME) }.to raise_error DirectionNotFoundException
      end
    end
  end
end