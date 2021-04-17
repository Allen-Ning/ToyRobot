#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/simulator/robot_runner'

begin
  ToyRobot::RobotRunner.new.run
rescue Exception => e
  warn e.message
end
