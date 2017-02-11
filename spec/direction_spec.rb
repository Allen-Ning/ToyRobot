require_relative '../lib/entity/direction'

module ToyRobot
  describe Direction do
    context 'should create direction instance' do
      it 'should not create invalid direction instance' do
        random = Random.new
        expect { Direction.new(:SOUTHEAST,
                               random.rand(-Random.new_seed..Random.new_seed),
                               random.rand(-Random.new_seed..Random.new_seed))
               }.to raise_error DirectionInvalidValueException
      end
    end

    context 'should find value' do
      it 'should find NORTH direction value' do
        index = Direction.find_value(:NORTH)

        expect(index).to eql(0)
      end

      it 'should find WEST direction value' do
        index = Direction.find_value(:WEST)

        expect(index).to eql(1)
      end

      it 'should find SOUTH direction value' do
        index = Direction.find_value(:SOUTH)

        expect(index).to eql(2)
      end

      it 'should find EAST direction value' do
        index = Direction.find_value(:EAST)

        expect(index).to eql(3)
      end

      it 'should raise DirectionNameNotFoundException when using invalid direction value' do
        expect { Direction.find_value(:INVALID_DIRECTION) }.to raise_error DirectionValueNotFound
      end
    end

    context 'should get direction' do
      it 'should get NORTH direction' do
        direction = Direction.get_direction(:NORTH)

        expect(direction.name).to eql(:NORTH)
        expect(direction.coordinate.x).to eql(0)
        expect(direction.coordinate.y).to eql(1)
      end

      it 'should get WEST direction' do
        direction = Direction.get_direction(:WEST)

        expect(direction.name).to eql(:WEST)
        expect(direction.coordinate.x).to eql(-1)
        expect(direction.coordinate.y).to eql(0)
      end

      it 'should get SOUTH direction' do
        direction = Direction.get_direction(:SOUTH)

        expect(direction.name).to eql(:SOUTH)
        expect(direction.coordinate.x).to eql(0)
        expect(direction.coordinate.y).to eql(-1)
      end

      it 'should get EAST direction' do
        direction = Direction.get_direction(:EAST)

        expect(direction.name).to eql(:EAST)
        expect(direction.coordinate.x).to eql(1)
        expect(direction.coordinate.y).to eql(0)
      end

      it 'should get invalid direction' do
        expect { Direction.get_direction(:INVALID_DIRECTION) }.to raise_error DirectionNotFoundException
      end
    end

    context 'should get valid left direction' do
      it 'should get left direction of NORTH direction' do
        left_direction = Direction.get_left_direction(:NORTH)

        expect(left_direction.name).to eql(:WEST)
        expect(left_direction.coordinate.x).to eql(-1)
        expect(left_direction.coordinate.y).to eql(0)
      end

      it 'should get left direction of WEST direction' do
        left_direction = Direction.get_left_direction(:WEST)

        expect(left_direction.name).to eql(:SOUTH)
        expect(left_direction.coordinate.x).to eql(0)
        expect(left_direction.coordinate.y).to eql(-1)
      end

      it 'should get left direction of SOUTH direction' do
        left_direction = Direction.get_left_direction(:SOUTH)

        expect(left_direction.name).to eql(:EAST)
        expect(left_direction.coordinate.x).to eql(1)
        expect(left_direction.coordinate.y).to eql(0)
      end

      it 'should get left direction of EAST direction' do
        left_direction = Direction.get_left_direction(:EAST)

        expect(left_direction.name).to eql(:NORTH)
        expect(left_direction.coordinate.x).to eql(0)
        expect(left_direction.coordinate.y).to eql(1)
      end
    end

    context 'should get valid right direction' do
      it 'should get right direction of NORTH direction' do
        right_direction = Direction.get_right_direction(:NORTH)

        expect(right_direction.name).to eql(:EAST)
        expect(right_direction.coordinate.x).to eql(1)
        expect(right_direction.coordinate.y).to eql(0)
      end

      it 'should get right direction of WEST direction' do
        right_direction = Direction.get_right_direction(:WEST)

        expect(right_direction.name).to eql(:NORTH)
        expect(right_direction.coordinate.x).to eql(0)
        expect(right_direction.coordinate.y).to eql(1)
      end

      it 'should get right direction of SOUTH direction' do
        right_direction = Direction.get_right_direction(:SOUTH)

        expect(right_direction.name).to eql(:WEST)
        expect(right_direction.coordinate.x).to eql(-1)
        expect(right_direction.coordinate.y).to eql(0)
      end

      it 'should get right direction of EAST direction' do
        right_direction = Direction.get_right_direction(:EAST)

        expect(right_direction.name).to eql(:SOUTH)
        expect(right_direction.coordinate.x).to eql(0)
        expect(right_direction.coordinate.y).to eql(-1)
      end
    end

    context 'should raise ArgumentError when getting left or right direction of an invalid direction' do
      it 'should raise ArgumentError when get left direction of an invalid direction' do
        expect { Direction.get_left_direction('north') }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when getting right direction of an invalid direction' do
        expect { Direction.get_right_direction('south') }.to raise_error ArgumentError

      end
    end
  end
end