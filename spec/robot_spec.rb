module ToyRobot
  describe Robot do
    let(:robot) { Robot.new }
    let(:board) { Board.new }
    let (:on_board) { robot.set_board(board) }
    let(:random) {Random.new}
    let(:invalid_x_coordinate) { random.rand(board.width + 1..Random.new_seed) }
    let(:invalid_y_coordinate) { random.rand(board.height + 1..Random.new_seed) }

    context 'should set robot position' do
      it 'should set valid robot position' do
        on_board

        expect(robot.place(:NORTH, 3, 3)).to be_true
      end

      it 'should not set invalid robot position - x coordinate larger than the width of board' do
        on_board

        expect(robot.place(:WEST, invalid_x_coordinate, 3)).to be_false
      end

      it 'should not set invalid robot position - y coordinate larger than the height of board' do
        on_board

        expect(robot.place(:SOUTH, invalid_x_coordinate, 2)).to be_false
      end

      it 'should not set invalid robot position - x, y coordinates larger than the width and height of board' do
        on_board

        expect(robot.place(:EAST, invalid_x_coordinate, invalid_y_coordinate)).to be_false
      end
    end

    context 'should turn left' do
      it 'should turn left when facing NORTH' do
        on_board
        robot.place(:NORTH, 3, 5)

        expect(robot.turn_left).to be_true
        expect(robot.direction.name).to eql(:WEST)
      end

      it 'should turn left when facing WEST' do
        on_board
        robot.place(:WEST, 2, 2)

        expect(robot.turn_left).to be_true
        expect(robot.direction.name).to eql(:SOUTH)
      end

      it 'should turn left when facing SOUTH' do
        on_board
        robot.place(:SOUTH, 3, 3)

        expect(robot.turn_left).to be_true
        expect(robot.direction.name).to eql(:EAST)
      end

      it 'should turn left when facing EAST' do
        on_board
        robot.place(:EAST, 3, 4)

        expect(robot.turn_left).to be_true
        expect(robot.direction.name).to eql(:NORTH)
      end

      it 'should not turn left when robot is not board - x coordinate larger than the width of board' do
        on_board
        robot.place(:NORTH, invalid_x_coordinate, 2)

        expect(robot.turn_left).to be_false
      end

      it 'should not turn left when robot is not board - y coordinate larger than the height of board' do
        on_board
        robot.place(:NORTH, invalid_y_coordinate, 3)

        expect(robot.turn_left).to be_false
      end

      it 'should not turn left when robot is not board - x, y coordinates larger than the width and height of board' do
        on_board
        robot.place(board, invalid_x_coordinate, invalid_y_coordinate)

        expect(robot.turn_left).to be_false
      end
    end

    context 'should turn right' do
      it 'should turn right when facing NORTH' do
        on_board
        robot.place(:NORTH, 2, 3)

        expect(robot.turn_right).to be_true
        expect(robot.direction.name).to eql(:EAST)
      end

      it 'should turn right when facing WEST' do
        on_board
        robot.place(:WEST, 3, 3)

        expect(robot.turn_right).to be_true
        expect(robot.direction.name).to eql(:NORTH)
      end

      it 'should turn right when facing SOUTH' do
        on_board
        robot.place(:SOUTH, 3, 3)

        expect(robot.turn_right).to be_true
        expect(robot.direction.name).to eql(:WEST)
      end

      it 'should turn right when facing EAST' do
        on_board
        robot.place(:EAST, 2, 3)

        expect(robot.turn_right).to be_true
        expect(robot.direction.name).to eql(:SOUTH)
      end

      it 'should not turn right when robot is not board - x coordinate larger than the width of board' do
        on_board
        robot.place(:NORTH, invalid_x_coordinate, 3)

        expect(robot.turn_right).to be_false
      end

      it 'should not turn right when robot is not board - y coordinate larger than the height of board' do
        on_board
        robot.place(:SOUTH, invalid_y_coordinate, 2)

        expect(robot.turn_right).to be_false
      end

      it 'should not turn right when robot is not board - x, y coordinates larger than the width and height of board' do
        on_board
        robot.place(:WEST, invalid_x_coordinate, invalid_y_coordinate)

        expect(robot.turn_right).to be_false
      end
    end

    context 'should move' do
      it 'should move when facing NORTH' do
        on_board
        robot.place(:NORTH, 3, 4)
        robot.move

        expect(robot.direction.name).to eql(:NORTH)
        expect(robot.current_coordinate.x).to eql(3)
        expect(robot.current_coordinate.y).to eql(5)
      end

      it 'should move when facing WEST' do
        on_board
        robot.place(:WEST, 2, 4)
        robot.move

        expect(robot.direction.name).to eql(:WEST)
        expect(robot.current_coordinate.x).to eql(1)
        expect(robot.current_coordinate.y).to eql(4)
      end

      it 'should move when facing SOUTH' do
        on_board
        robot.place(:SOUTH, 1, 3)
        robot.move

        expect(robot.direction.name).to eql(:SOUTH)
        expect(robot.current_coordinate.x).to eql(1)
        expect(robot.current_coordinate.y).to eql(2)
      end

      it 'should move when facing EAST' do
        on_board
        robot.place(:EAST, 1, 3)
        robot.move

        expect(robot.direction.name).to eql(:EAST)
        expect(robot.current_coordinate.x).to eql(2)
        expect(robot.current_coordinate.y).to eql(3)
      end

      it 'should move when not on board' do
        expect(robot.move).to be_false
      end
    end

    context 'should not move' do
      it 'should not move over board width' do
        on_board
        robot.place(:EAST, 5, 3)
        robot.move

        expect(robot.direction.name).to eql(:EAST)
        expect(robot.current_coordinate.x).to eql(5)
        expect(robot.current_coordinate.y).to eql(3)
      end

      it 'should not move less than x coordinate 0' do
        on_board
        robot.place(:WEST, 0, 3)
        robot.move

        expect(robot.direction.name).to eql(:WEST)
        expect(robot.current_coordinate.x).to eql(0)
        expect(robot.current_coordinate.y).to eql(3)
      end

      it 'should not move over board height' do
        on_board
        robot.place(:NORTH, 3, 5)
        robot.move

        expect(robot.direction.name).to eql(:NORTH)
        expect(robot.current_coordinate.x).to eql(3)
        expect(robot.current_coordinate.y).to eql(5)
      end

      it 'should not move less than y coordinate 0' do
        on_board
        robot.place(:SOUTH, 3, 0)
        robot.move

        expect(robot.direction.name).to eql(:SOUTH)
        expect(robot.current_coordinate.x).to eql(3)
        expect(robot.current_coordinate.y).to eql(0)
      end

    end

    context 'should report' do
      it 'should report when facing NORTH on board' do
        on_board
        robot.place(:NORTH, 3, 4)

        expect(robot.report).to eql([:NORTH, 3, 4])
      end

      it 'should report when facing WEST on board' do
        on_board
        robot.place(:WEST, 4, 5)

        expect(robot.report).to eql([:WEST, 4, 5])
      end

      it 'should report when facing SOUTH on board' do
        on_board
        robot.place(:SOUTH, 5, 5)

        expect(robot.report).to eql([:SOUTH, 5, 5])
      end

      it 'should report when on facing EAST on board' do
        on_board
        robot.place(:EAST, 3, 5)

        expect(robot.report).to eql([:EAST, 3, 5])
      end

      it 'should not report when not on board' do
        expect(robot.report).to eql([])
      end
    end
  end
end