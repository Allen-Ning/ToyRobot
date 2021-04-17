require 'ffaker'

require 'model/board'
require 'model/robot'
require 'model/coordinate'
require 'model/direction'
require 'simulator/command_processor'

RSpec::Matchers.define_negated_matcher :not_change, :change
