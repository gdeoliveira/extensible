unless ENV["COVERAGE"].nil?
  require "codeclimate-test-reporter"
  SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter
    ]
    add_filter "/spec/"
  end
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "extensible"

RSpec.configure do |config|
  config.color = true
  config.order = :rand
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
