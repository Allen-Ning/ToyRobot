# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe Board do
    let(:width)  { FFaker::Random.rand(1..1000) }
    let(:height) { FFaker::Random.rand(1..1000) }

    subject { Board.new(width: width, height: height) }

    it 'should create valid board' do
      expect(subject).to have_attributes(
        width: width,
        height: height
      )
    end

    context 'should not create invalid board' do
      context 'when width is invalid value' do
        let(:width) { FFaker::Random.rand(-1000..-1) }

        it 'does not create board with invalid board height' do
          expect { subject }.to raise_error InvalidBoardWidthError
        end
      end

      context 'whne heigh is invalid value' do
        let(:height) { FFaker::Random.rand(-1000..-1) }

        it 'does not create invalid board with invalid height' do
          expect { subject }.to raise_error InvalidBoardHeightError
        end
      end
    end
  end
end
