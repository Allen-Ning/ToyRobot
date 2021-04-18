# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe Board do
    let(:width)  { FFaker::Random.rand(1..1000) }
    let(:height) { FFaker::Random.rand(1..1000) }

    describe '#initialize' do
      subject { Board.new(width: width, height: height) }

      context 'when valid values are provided' do
        it 'creates valid board' do
          expect(subject).to have_attributes(
            width: width,
            height: height
          )
        end
      end

      context 'when invalid values are provided' do
        context 'when width is invalid value' do
          let(:width) { FFaker::Random.rand(-1000..-1) }

          it { expect { subject }.to raise_error InvalidBoardWidthError }
        end

        context 'whne height is invalid value' do
          let(:height) { FFaker::Random.rand(-1000..-1) }

          it { expect { subject }.to raise_error InvalidBoardHeightError }
        end
      end
    end
  end
end
