# frozen_string_literal: true

require "simplecov" if ENV["COVERAGE_ENABLED"]

lib = File.expand_path("../../lib/", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
