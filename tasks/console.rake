# frozen_string_literal: true

CONSOLE_GEM_NAME = Bundler::GemHelper.gemspec.name.dup.freeze
CONSOLE_GEM_VERSION = Bundler::GemHelper.gemspec.version.dup.freeze

desc "Open Pry console with #{CONSOLE_GEM_NAME}-#{CONSOLE_GEM_VERSION}.gem preloaded"
task :console do
  require CONSOLE_GEM_NAME
  require "pry"
  Pry.start
end
