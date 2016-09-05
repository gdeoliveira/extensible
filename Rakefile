# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

Pathname.glob(File.expand_path("../tasks/*.rake", __FILE__)) {|filename| load filename }

task :default => :coverage
