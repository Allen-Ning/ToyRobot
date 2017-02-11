require_relative '../lib/entity/board'

module ToyRobot
  describe Board do
    let(:random) { Random.new }
    let(:width)  { random.rand(0..Random.new_seed) }
    let(:height) { random.rand(0..Random.new_seed) }

    it 'should create valid board' do
      board = Board.new(width, height)
      expect(board.width).to eql(width)
      expect(board.height).to eql(height)
    end

    context 'should not create invalid board' do
      it 'should not create invalid board width' do
        expect { Board.new(-width, height) }.to raise_error InvalidBoardWidthException
      end

      it 'should not create invalid board height' do
        expect { Board.new(width, -height) }.to raise_error InvalidBoardHeightException
      end
    end
  end
end