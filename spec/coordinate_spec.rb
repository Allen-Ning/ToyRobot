require_relative '../lib/entity/coordinate'

module ToyRobot
  describe Coordinate do
    let(:random) { Random.new }

    it 'should add coordinate' do
      x1 = random.rand(-Random.new_seed..Random.new_seed)
      y1 = random.rand(-Random.new_seed..Random.new_seed)

      x2 = random.rand(-Random.new_seed..Random.new_seed)
      y2 = random.rand(-Random.new_seed..Random.new_seed)

      coordinate = Coordinate.new(x1, y1)
      another_coordinate = Coordinate.new(x2, y2)
      coordinate.add_coordinate(another_coordinate)
      expect(coordinate.x).to eql(x1 + x2)
      expect(coordinate.y).to eql(y1 + y2)
    end
  end
end