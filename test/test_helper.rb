$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'surveyor/nps'
require 'minitest/autorun'
require "minitest/reporters"
require "minitest/given"
# require "pry"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
