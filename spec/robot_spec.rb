# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe Robot do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let(:x) { FFaker::Random.rand(0..board.width - 1) }
    let(:y) { FFaker::Random.rand(0..board.height - 1) }
    let(:invalid_x_coordinate) { FFaker::Random.rand(board.width + 1..board.width + 1000) }
    let(:invalid_y_coordinate) { FFaker::Random.rand(board.height + 1..board.height + 1000) }

    context 'when not on board' do
      it 'does not move' do
        expect(robot.move).to be false
      end

      it 'does not report' do
        expect(robot.report).to eq([])
      end

      it 'ignores command before a valid PLACE command' do
        robot.move

        expect(robot.report).to eq([])
      end
    end

    context 'when on board' do
      describe '#place' do
        subject { robot.place(board: board, direction_name: direction, x: x, y: y) }

        context 'when setting valid robot position' do
          let(:direction) { :NORTH }

          it { is_expected.to be true }
        end

        context 'when setting invalid robot position - x coordinate larger than the width of board' do
          let(:direction) { :WEST }
          let(:x) { invalid_x_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end

        context 'when setting invalid robot position - y coordinate larger than the height of board' do
          let(:direction) { :SOUTH }
          let(:x) { invalid_x_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end

        context 'when setting invalid robot position - x, y coordinates larger than the width and height of board' do
          let(:direction) { :EAST }
          let(:x) { invalid_x_coordinate }
          let(:y) { invalid_y_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end
      end

      describe '#turn_left' do
        subject { robot.turn_left }

        before do
          robot.place(board: board, direction_name: direction, x: x, y: y)
        end

        context 'when facing NORTH' do
          let(:direction) { :NORTH }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:NORTH)
              .to(:WEST)
          }
        end

        context 'when facing WEST' do
          let(:direction) { :WEST }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:WEST)
              .to(:SOUTH)
          }
        end

        context 'when facing SOUTH' do
          let(:direction) { :SOUTH }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:SOUTH)
              .to(:EAST)
          }
        end

        context 'when facing EAST' do
          let(:direction) { :EAST }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:EAST)
              .to(:NORTH)
          }
        end

        context 'when robot is not board - x coordinate larger than the width of board' do
          let(:direction) { :NORTH }
          let(:x) { invalid_x_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end

        context 'when robot is not board - y coordinate larger than the height of board' do
          let(:direction) { :NORTH }
          let(:x) { invalid_y_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end

        context 'when robot is not board - x, y coordinates larger than the width and height of board' do
          let(:direction) { :board }
          let(:x) { invalid_x_coordinate }
          let(:y) { invalid_y_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end
      end

      describe '#turn_right' do
        subject { robot.turn_right }

        before do
          robot.place(board: board, direction_name: direction, x: x, y: y)
        end

        context 'when facing NORTH' do
          let(:direction) { :NORTH }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:NORTH)
              .to(:EAST)
          }
        end

        context 'when facing WEST' do
          let(:direction) { :WEST }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:WEST)
              .to(:NORTH)
          }
        end

        context 'when facing SOUTH' do
          let(:direction) { :SOUTH }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:SOUTH)
              .to(:WEST)
          }
        end

        context 'when facing EAST' do
          let(:direction) { :EAST }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:EAST)
              .to(:SOUTH)
          }
        end

        context 'when robot is not board - x coordinate larger than the width of board' do
          let(:direction) { :NORTH }
          let(:x) { invalid_x_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end

        context 'when robot is not board - y coordinate larger than the height of board' do
          let(:direction) { :SOUTH }
          let(:y) { invalid_y_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end

        context 'when robot is not board - x, y coordinates larger than the width and height of board' do
          let(:direction) { :WEST }
          let(:x) { invalid_x_coordinate }
          let(:y) { invalid_y_coordinate }

          it {
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          }
        end
      end

      describe '#move' do
        let(:x) { FFaker::Random.rand(1..board.width - 2) }
        let(:y) { FFaker::Random.rand(1..board.height - 2) }

        subject { robot.move }

        before do
          robot.place(board: board, direction_name: direction, x: x, y: y)
        end

        context 'when facing NORTH' do
          let(:direction) { :NORTH }

          it {
            expect { subject }
              .to change { robot.coordinate.y }
              .from(y)
              .to(y + 1)
              .and not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.direction.name }
              .from(direction)
          }
        end

        context 'when facing WEST' do
          let(:direction) { :WEST }

          it {
            expect { subject }
              .to change { robot.coordinate.x }
              .from(x)
              .to(x - 1)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(direction)
          }
        end

        context 'when facing SOUTH' do
          let(:direction) { :SOUTH }

          it {
            expect { subject }
              .to change { robot.coordinate.y }
              .from(y)
              .to(y - 1)
              .and not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.direction.name }
              .from(direction)
          }
        end

        context 'when facing EAST' do
          let(:direction) { :EAST }

          it {
            expect { subject }
              .to change { robot.coordinate.x }
              .from(x)
              .to(x + 1)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(direction)
          }
        end

        context 'when not moving' do
          context 'when moving over board width' do
            let(:direction) { :EAST }
            let(:x) { board.width - 1 }

            it {
              expect { subject }
                .to not_change { robot.coordinate.x }
                .from(x)
                .and not_change { robot.coordinate.y }
                .from(y)
                .and not_change { robot.direction.name }
                .from(direction)

              expect(subject).to be false
            }
          end

          context 'when moving less than x coordinate 0' do
            let(:direction) { :WEST }
            let(:x) { 0 }

            it {
              expect { subject }
                .to not_change { robot.coordinate.x }
                .from(x)
                .and not_change { robot.coordinate.y }
                .from(y)
                .and not_change { robot.direction.name }
                .from(direction)

              expect(subject).to be false
            }
          end

          context 'when moving over board height' do
            let(:direction) { :NORTH }
            let(:y) { board.height - 1 }

            it {
              expect { subject }
                .to not_change { robot.coordinate.x }
                .from(x)
                .and not_change { robot.coordinate.y }
                .from(y)
                .and not_change { robot.direction.name }
                .from(direction)

              expect(subject).to be false
            }
          end

          context 'when moving less than y coordinate 0' do
            let(:direction) { :SOUTH }
            let(:y) { 0 }

            it {
              expect { subject }
                .to not_change { robot.coordinate.x }
                .from(x)
                .and not_change { robot.coordinate.y }
                .from(y)
                .and not_change { robot.direction.name }
                .from(direction)

              expect(subject).to be false
            }
          end
        end
      end

      describe '#report' do
        subject { robot.report }

        before do
          robot.place(board: board, direction_name: direction, x: x, y: y)
        end

        context 'when facing NORTH' do
          let(:direction) { :NORTH }

          it { is_expected.to eq([:NORTH, x, y]) }
        end

        context 'when facing WEST' do
          let(:direction) { :WEST }

          it { is_expected.to eq([:WEST, x, y]) }
        end

        context 'when facing SOUTH' do
          let(:direction) { :SOUTH }

          it { is_expected.to eq([:SOUTH, x, y]) }
        end

        context 'when facing EAST' do
          let(:direction) { :EAST }

          it { is_expected.to eq([:EAST, x, y]) }
        end

        context 'when invalid command is given' do
          let(:direction) { :EAST }
          let(:y) { board.height - 1 }

          it 'ignores the second PLACE command' do
            robot.place(board: board, direction_name: :WEST, x: 2, y: 2)

            is_expected.to eq([:EAST, x, y])
          end
        end
      end
    end
  end
end
