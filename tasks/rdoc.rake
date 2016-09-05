# frozen_string_literal: true

require "rdoc/rdoc"
require_relative "rdoc/server"

RDOC_OPTIONS = %w(--all --force-output) | Bundler::GemHelper.gemspec.rdoc_options

desc "Generate RDoc documentation files"
task :rdoc do
  RDoc::RDoc.new.document RDOC_OPTIONS
end
