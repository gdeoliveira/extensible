require "bundler/gem_tasks"
require "rspec/core/rake_task"

Dir[File.join(File.dirname(__FILE__), "tasks", "**", "*.rb")].each do |file|
  require file
end

RSpec::Core::RakeTask.new(:spec)

task default: :coverage
