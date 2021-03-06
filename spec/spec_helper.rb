# frozen_string_literal: true

require 'ffaker'

$LOAD_PATH.unshift File.expand_path('../app', File.dirname(__FILE__))

require 'model/board'
require 'model/robot'
require 'model/coordinate'
require 'model/direction'
require 'simulator/command_processor'

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
