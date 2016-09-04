# frozen_string_literal: true

require "codeclimate-test-reporter"

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formater::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]

  add_filter {|file| file.filename !~ %r{\A/opt/app/lib/} }
end
