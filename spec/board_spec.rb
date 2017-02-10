require 'spec_helper'

module ToyRobot
  describe Board do
    let(:random) { Random.new }
    let(:width)  { random.rand(0..Random.new_seed) }
    let(:height) { random.rand(0..Random.new_seed) }

    it 'create valid board' do
      board = Board.new(width, height)
      expect(board.width).to eql(width)
      expect(board.height).to eql(height)
    end

    context 'create invalid board' do
      it 'can create invalid board width' do
        board = Board.new(-width, height)
        expect(board.width).to eql(Board::WIDTH)
        expect(board.height).to eql(Board::HEIGHT)
      end

      it 'create invalid board height' do
        board = Board.new(width, -height)
        expect(board.width).to eql(Board::WIDTH)
        expect(board.height).to eql(Board::HEIGHT)
      end

      it 'create invalid board width and height' do
        board = Board.new(-width, -height)
        expect(board.width).to eql(Board::WIDTH)
        expect(board.height).to eql(Board::HEIGHT)
      end
    end
  end
end