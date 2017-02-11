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
        board = Board.new(-width, height)
        expect(board.width).to eql(Board::WIDTH)
        expect(board.height).to eql(Board::HEIGHT)
      end

      it 'should not create invalid board height' do
        board = Board.new(width, -height)
        expect(board.width).to eql(Board::WIDTH)
        expect(board.height).to eql(Board::HEIGHT)
      end

      it 'should not create invalid board width and height' do
        board = Board.new(-width, -height)
        expect(board.width).to eql(Board::WIDTH)
        expect(board.height).to eql(Board::HEIGHT)
      end
    end
  end
end