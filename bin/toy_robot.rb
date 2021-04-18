#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/boot'

begin
  ToyRobot::RobotRunner.new.run
rescue StandardError => e
  warn e.message
end
