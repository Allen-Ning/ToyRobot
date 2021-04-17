# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe Coordinate do
    let(:random) { Random.new }
    let(:subject) { coordinate.add_coordinate(another_coordinate) }
    let(:x1) { random.rand(-Random.new_seed..Random.new_seed) }
    let(:y1) { random.rand(-Random.new_seed..Random.new_seed) }
    let(:x2) { random.rand(-Random.new_seed..Random.new_seed) }
    let(:y2) { random.rand(-Random.new_seed..Random.new_seed) }
    let(:coordinate) { Coordinate.new(x: x1, y: y1) }
    let(:another_coordinate) { Coordinate.new(x: x2, y: y2) }

    it 'should add coordinate' do
      expect { subject }
        .to change { coordinate.x }
        .from(x1)
        .to(x1 + x2)
        .and change { coordinate.y }
        .from(y1)
        .to(y1 + y2)
    end
  end
end
