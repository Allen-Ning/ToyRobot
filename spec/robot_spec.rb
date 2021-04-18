# frozen_string_literal: true

require 'spec_helper'

module ToyRobot
  describe Robot do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    ################################################################
    # double check bountry
    #######################################################
    let(:x) { FFaker::Random.rand(0..board.width - 1) }
    let(:y) { FFaker::Random.rand(0..board.height - 1) }
    let(:invalid_x_coordinate) { FFaker::Random.rand(board.width + 1..board.width + 1000) }
    let(:invalid_y_coordinate) { FFaker::Random.rand(board.height + 1..board.height + 1000) }

    context 'when not on board' do
      it 'should move when not on board' do
        expect(robot.move).to be false
      end

      it 'should not report when not on board' do
        expect(robot.report).to eql([])
      end

      it 'should ignore command before a valid PLACE command' do
        robot.move

        expect(robot.report).to eql([])
      end
    end

    context 'when on board' do
      context 'should set robot position' do
        subject { robot.place(board: board, direction_name: value, x: x, y: y) }

        context 'should set valid robot position' do
          let(:value) { :NORTH }

          it {
            is_expected.to be true
          }
        end

        context 'should not set invalid robot position - x coordinate larger than the width of board' do
          let(:value) { :WEST }
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

        context 'should not set invalid robot position - y coordinate larger than the height of board' do
          let(:value) { :SOUTH }
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

        context 'should not set invalid robot position - x, y coordinates larger than the width and height of board' do
          let(:value) { :EAST }
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

      context 'should turn left' do
        subject { robot.turn_left }

        before do
          robot.place(board: board, direction_name: value, x: x, y: y)
        end

        context 'should turn left when facing NORTH' do
          let(:value) { :NORTH }

          it '' do
            expect { subject }
              .to change { robot.direction.name }
              .from(:NORTH)
              .to(:WEST)
          end
        end

        context 'should turn left when facing WEST' do
          let(:value) { :WEST }

          it '' do
            expect { subject }
              .to change { robot.direction.name }
              .from(:WEST)
              .to(:SOUTH)
          end
        end

        context 'should turn left when facing SOUTH' do
          let(:value) { :SOUTH }

          it '' do
            expect { subject }
              .to change { robot.direction.name }
              .from(:SOUTH)
              .to(:EAST)
          end
        end

        context 'should turn left when facing EAST' do
          let(:value) { :EAST }

          it '' do
            expect { subject }
              .to change { robot.direction.name }
              .from(:EAST)
              .to(:NORTH)
          end
        end

        context 'should not turn left when robot is not board - x coordinate larger than the width of board' do
          let(:value) { :NORTH }
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

        context '' do
          let(:value) { :NORTH }
          let(:x) { invalid_y_coordinate }

          it 'should not turn left when robot is not board - y coordinate larger than the height of board' do
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          end
        end

        context '' do
          let(:value) { :board }
          let(:x) { invalid_x_coordinate }
          let(:y) { invalid_y_coordinate }

          it 'should not turn left when robot is not board - x, y coordinates larger than the width and height of board' do
            expect { subject }
              .to not_change { robot.direction }
              .from(nil)
              .and not_change { robot.coordinate }
              .from(nil)

            expect(subject).to be false
          end
        end
      end

      context 'should turn right' do
        subject { robot.turn_right }

        before do
          robot.place(board: board, direction_name: value, x: x, y: y)
        end

        context 'should turn right when facing NORTH' do
          let(:value) { :NORTH }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:NORTH)
              .to(:EAST)
          }
        end

        context 'should turn right when facing WEST' do
          let(:value) { :WEST }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:WEST)
              .to(:NORTH)
          }
        end

        context 'should turn right when facing SOUTH' do
          let(:value) { :SOUTH }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:SOUTH)
              .to(:WEST)
          }
        end

        context 'should turn right when facing EAST' do
          let(:value) { :EAST }

          it {
            expect { subject }
              .to change { robot.direction.name }
              .from(:EAST)
              .to(:SOUTH)
          }
        end

        context 'should not turn right when robot is not board - x coordinate larger than the width of board' do
          let(:value) { :NORTH }
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

        context 'should not turn right when robot is not board - y coordinate larger than the height of board' do
          let(:value) { :SOUTH }
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

        context 'should not turn right when robot is not board - x, y coordinates larger than the width and height of board' do
          let(:value) { :WEST }
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

      context 'should move' do
        let(:x) { FFaker::Random.rand(1..board.width - 2) }
        let(:y) { FFaker::Random.rand(1..board.height - 2) }

        subject { robot.move }

        before do
          robot.place(board: board, direction_name: value, x: x, y: y)
        end

        context 'should move when facing NORTH' do
          let(:value) { :NORTH }

          it '' do
            expect { subject }
              .to change { robot.coordinate.y }
              .from(y)
              .to(y + 1)
              .and not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.direction.name }
              .from(value)
          end
        end

        context 'should move when facing WEST' do
          let(:value) { :WEST }

          it '' do
            expect { subject }
              .to change { robot.coordinate.x }
              .from(x)
              .to(x - 1)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(value)
          end
        end

        context 'should move when facing SOUTH' do
          let(:value) { :SOUTH }

          it '' do
            expect { subject }
              .to change { robot.coordinate.y }
              .from(y)
              .to(y - 1)
              .and not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.direction.name }
              .from(value)
          end
        end

        context 'should move when facing EAST' do
          let(:value) { :EAST }

          it '' do
            expect { subject }
              .to change { robot.coordinate.x }
              .from(x)
              .to(x + 1)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(value)
          end
        end
      end

      context 'should not move' do
        let(:x) { FFaker::Random.rand(1..board.width - 2) }
        let(:y) { FFaker::Random.rand(1..board.height - 2) }

        subject { robot.move }

        before do
          robot.place(board: board, direction_name: value, x: x, y: y)
        end

        context 'should not move over board width' do
          let(:value) { :EAST }
          let(:x) { board.width - 1 }

          it '' do
            expect { subject }
              .to not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(value)

            expect(subject).to be false
          end
        end

        context 'should not move less than x coordinate 0' do
          let(:value) { :WEST }
          let(:x) { 0 }

          it '' do
            expect { subject }
              .to not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(value)

            expect(subject).to be false
          end
        end

        context 'should not move over board height' do
          let(:value) { :NORTH }
          let(:y) { board.height - 1 }

          it '' do
            expect { subject }
              .to not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(value)

            expect(subject).to be false
          end
        end

        context 'should not move less than y coordinate 0' do
          let(:value) { :SOUTH }
          let(:y) { 0 }

          it '' do
            expect { subject }
              .to not_change { robot.coordinate.x }
              .from(x)
              .and not_change { robot.coordinate.y }
              .from(y)
              .and not_change { robot.direction.name }
              .from(value)

            expect(subject).to be false
          end
        end
      end

      context 'should report' do
        subject { robot.report }

        before do
          robot.place(board: board, direction_name: value, x: x, y: y)
        end

        context 'should report when facing NORTH on board' do
          let(:value) { :NORTH }

          it { is_expected.to eq([:NORTH, x, y]) }
        end

        context 'should report when facing WEST on board' do
          let(:value) { :WEST }

          it { is_expected.to eq([:WEST, x, y]) }
        end

        context 'should report when facing SOUTH on board' do
          let(:value) { :SOUTH }

          it { is_expected.to eq([:SOUTH, x, y]) }
        end

        context 'should report when on facing EAST on board' do
          let(:value) { :EAST }

          it { is_expected.to eq([:EAST, x, y]) }
        end

        context 'should ignore the second PLACE command' do
          let(:value) { :EAST }
          let(:x) { 3 }
          let(:y) { 4 }

          it '' do
            robot.place(board: board, direction_name: :WEST, x: 2, y: 2)

            is_expected.to eq([:EAST, x, y])
          end
        end
      end
    end
  end
end
