# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe Coordinate do
    let(:x1) { FFaker::Random.rand(-1000..1000) }
    let(:y1) {  FFaker::Random.rand(-1000..1000) }
    let(:x2) {  FFaker::Random.rand(-1000..1000) }
    let(:y2) {  FFaker::Random.rand(-1000..1000) }
    let(:coordinate) { Coordinate.new(x: x1, y: y1) }
    let(:another_coordinate) { Coordinate.new(x: x2, y: y2) }

    describe '#add' do
      subject { coordinate.add(another_coordinate) }

      it 'adds coordinate' do
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
end
