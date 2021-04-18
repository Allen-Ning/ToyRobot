# frozen_string_literal: true

module ToyRobot
  describe Direction do
    context 'should create direction instance' do
      it 'should not create invalid direction instance' do
        expect do
          Direction.new(
            name: :SOUTHEAST,
            x: FFaker::Random.rand(-1000..1000),
            y: FFaker::Random.rand(-1000..1000)
          )
        end.to raise_error DirectionInvalidValueError
      end
    end

    context 'should find value' do
      subject { Direction.find_value(direction) }

      context 'when north direction' do
        let(:direction) { :NORTH }

        it { is_expected.to eq(0) }
      end

      context 'when west direction' do
        let(:direction) { :WEST }

        it { is_expected.to eq(1) }
      end

      context 'when south direction' do
        let(:direction) { :SOUTH }

        it { is_expected.to eq(2) }
      end

      context 'when east direction' do
        let(:direction) { :EAST }

        it { is_expected.to eq(3) }
      end

      context 'when invalid direction' do
        let(:direction) { :INVALID_DIRECTION }

        it 'should raise DirectionNameNotFoundError when using invalid direction value' do
          expect { subject }.to raise_error DirectionValueNotFoundError
        end
      end
    end

    context 'should get direction' do
      subject { Direction.direction(value) }

      context 'when get north direction' do
        let(:value) { :NORTH }

        it {
          is_expected.to have_attributes(
            name: :NORTH,
            coordinate: have_attributes(
              x: 0,
              y: 1
            )
          )
        }
      end

      context 'should get WEST direction' do
        let(:value) { :WEST }

        it {
          is_expected.to have_attributes(
            name: :WEST,
            coordinate: have_attributes(
              x: -1,
              y: 0
            )
          )
        }
      end

      context 'should get SOUTH direction' do
        let(:value) { :SOUTH }

        it {
          is_expected.to have_attributes(
            name: :SOUTH,
            coordinate: have_attributes(
              x: 0,
              y: -1
            )
          )
        }
      end

      context 'should get EAST direction' do
        let(:value) { :EAST }

        it {
          is_expected.to have_attributes(
            name: :EAST,
            coordinate: have_attributes(
              x: 1,
              y: 0
            )
          )
        }
      end

      context 'when invalid direction' do
        let(:value) { :INVALID_DIRECTION }

        it 'should get invalid direction' do
          expect { subject }.to raise_error DirectionNotFoundError
        end
      end
    end

    context 'should get valid left direction' do
      subject { Direction.left_direction(value) }

      context 'when getting left direction of NORTH direction' do
        let(:value) { :NORTH }

        it {
          is_expected.to have_attributes(
            name: :WEST,
            coordinate: have_attributes(
              x: -1,
              y: 0
            )
          )
        }
      end

      context 'should get left direction of WEST direction' do
        let(:value) { :WEST }

        it {
          is_expected.to have_attributes(
            name: :SOUTH,
            coordinate: have_attributes(
              x: 0,
              y: -1
            )
          )
        }
      end

      context 'should get left direction of SOUTH direction' do
        let(:value) { :SOUTH }

        it {
          is_expected.to have_attributes(
            name: :EAST,
            coordinate: have_attributes(
              x: 1,
              y: 0
            )
          )
        }
      end

      context 'should get left direction of EAST direction' do
        let(:value) { :EAST }

        it {
          is_expected.to have_attributes(
            name: :NORTH,
            coordinate: have_attributes(
              x: 0,
              y: 1
            )
          )
        }
      end

      context 'when getting error' do
        let(:value) { 'north' }
        it 'should raise ArgumentError when get left direction of an invalid direction' do
          expect { subject }.to raise_error ArgumentError
        end
      end
    end

    context 'when getting right direction xxxx' do
      subject { Direction.right_direction(value) }

      context 'should get right direction of NORTH direction' do
        let(:value) { :NORTH }

        it {
          is_expected.to have_attributes(
            name: :EAST,
            coordinate: have_attributes(
              x: 1,
              y: 0
            )
          )
        }
      end

      context 'should get right direction of WEST direction' do
        let(:value) { :WEST }

        it {
          is_expected.to have_attributes(
            name: :NORTH,
            coordinate: have_attributes(
              x: 0,
              y: 1
            )
          )
        }
      end

      context 'should get right direction of SOUTH direction' do
        let(:value) { :SOUTH }

        it {
          is_expected.to have_attributes(
            name: :WEST,
            coordinate: have_attributes(
              x: -1,
              y: 0
            )
          )
        }
      end

      context 'should get right direction of EAST direction' do
        let(:value) { :EAST }

        it {
          is_expected.to have_attributes(
            name: :SOUTH,
            coordinate: have_attributes(
              x: 0,
              y: -1
            )
          )
        }
      end

      context 'when error' do
        let(:value) { 'south' }

        it 'should raise ArgumentError when getting right direction of an invalid direction' do
          expect { subject }.to raise_error ArgumentError
        end
      end
    end
  end
end
