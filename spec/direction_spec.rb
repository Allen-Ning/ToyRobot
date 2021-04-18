# frozen_string_literal: true

module ToyRobot
  describe Direction do
    describe '#initialize' do
      context 'when creating direction instance' do
        it 'does not create invalid direction instance' do
          expect do
            Direction.new(
              name: :SOUTHEAST,
              x: FFaker::Random.rand(-1000..1000),
              y: FFaker::Random.rand(-1000..1000)
            )
          end.to raise_error DirectionInvalidValueError
        end
      end
    end

    describe '#finds_value' do
      subject { Direction.find_value(direction) }

      context 'when north direction is given' do
        let(:direction) { :NORTH }

        it { is_expected.to eq(0) }
      end

      context 'when west direction is given' do
        let(:direction) { :WEST }

        it { is_expected.to eq(3) }
      end

      context 'when south direction is given' do
        let(:direction) { :SOUTH }

        it { is_expected.to eq(2) }
      end

      context 'when east direction is given' do
        let(:direction) { :EAST }

        it { is_expected.to eq(1) }
      end

      context 'when invalid direction is given' do
        let(:direction) { :INVALID_DIRECTION }

        it 'raises DirectionNameNotFoundError' do
          expect { subject }.to raise_error DirectionValueNotFoundError
        end
      end
    end

    describe '#direction' do
      subject { Direction.direction(direction) }

      context 'when getting north direction' do
        let(:direction) { :NORTH }

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

      context 'when getting WEST direction' do
        let(:direction) { :WEST }

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

      context 'when getting SOUTH direction' do
        let(:direction) { :SOUTH }

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

      context 'when getting EAST direction' do
        let(:direction) { :EAST }

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

      context 'when getting an invalid direction' do
        let(:direction) { :INVALID_DIRECTION }

        it 'raises DirectionNotFoundError' do
          expect { subject }.to raise_error DirectionNotFoundError
        end
      end
    end

    describe '#left_direction' do
      subject { Direction.left_direction(direction) }

      context 'when getting left direction of NORTH direction' do
        let(:direction) { :NORTH }

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

      context 'when getting left direction of WEST direction' do
        let(:direction) { :WEST }

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

      context 'when getting left direction of SOUTH direction' do
        let(:direction) { :SOUTH }

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

      context 'when getting left direction of EAST direction' do
        let(:direction) { :EAST }

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

      context 'when getting invalid directio' do
        let(:direction) { 'north' }

        it 'raises DirectionNotFoundError' do
          expect { subject }.to raise_error DirectionNotFoundError
        end
      end
    end

    describe 'right_direction' do
      subject { Direction.right_direction(direction) }

      context 'when getting right direction of NORTH direction' do
        let(:direction) { :NORTH }

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

      context 'when getting right direction of WEST direction' do
        let(:direction) { :WEST }

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

      context 'when getting right direction of SOUTH direction' do
        let(:direction) { :SOUTH }

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

      context 'when getting right direction of EAST direction' do
        let(:direction) { :EAST }

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

      context 'when getting an invalid direction' do
        let(:direction) { 'south' }

        it 'raises DirectionNotFoundError' do
          expect { subject }.to raise_error DirectionNotFoundError
        end
      end
    end
  end
end
