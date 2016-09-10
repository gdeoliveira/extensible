# frozen_string_literal: true

require "English"

desc "Run code syntax checks"
task :syntax do
  system "bundle exec rubocop"
  exit $CHILD_STATUS.exitstatus
end
