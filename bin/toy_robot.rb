#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/simulator/robot_runner'

begin
  ToyRobot::RobotRunner.new.run
rescue Error => e
  warn e.message
end
