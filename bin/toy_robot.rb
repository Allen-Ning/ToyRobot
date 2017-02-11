#!/usr/bin/env ruby

require_relative '../lib/simulator/robot_runner'

begin
  ToyRobot::RobotRunner.new.run
rescue Exception => exception
  STDERR.puts exception.message
end
