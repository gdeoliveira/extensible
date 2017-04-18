# coding: utf-8

lib = File.expand_path("../lib/".freeze, __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "extensible/version".freeze

Gem::Specification.new do |spec|
  spec.author = "Gabriel de Oliveira".freeze
  spec.files = Dir[
    "*.gemspec".freeze,
    "LICENSE.*".freeze,
    "README.*".freeze,
    "lib/**/*.rb".freeze
  ]
  spec.name = "extensible".freeze
  spec.summary = "Ruby extensions made easy".freeze
  spec.version = Extensible::VERSION

  spec.email = "deoliveira.gab@gmail.com".freeze
  spec.homepage = "https://github.com/gdeoliveira/extensible".freeze
  spec.license = "MIT".freeze

  spec.description = "Use Extensible on your custom extensions in order to get a set of advantages over traditional " \
                     "extensions that override the Module#extended method directly.".freeze
  spec.rdoc_options = [
    "--main=README.md".freeze,
    "--title=Extensible".freeze,
    "LICENSE.md".freeze,
    "README.md".freeze,
    "lib/".freeze
  ].freeze

  spec.add_development_dependency "bundler".freeze, "~> 1.14".freeze
  spec.add_development_dependency "codeclimate-test-reporter".freeze, "~> 1.0".freeze
  spec.add_development_dependency "guard-rspec".freeze, "~> 4.7".freeze
  spec.add_development_dependency "guard-rubocop".freeze, "~> 1.2".freeze
  spec.add_development_dependency "io-console".freeze, "~> 0.4".freeze
  spec.add_development_dependency "pry-byebug".freeze, "~> 3.4".freeze
  spec.add_development_dependency "rake".freeze, "~> 12.0".freeze
  spec.add_development_dependency "rdoc".freeze, "~> 5.1".freeze
  spec.add_development_dependency "ruby_gntp".freeze, "~> 0.3".freeze
  spec.add_development_dependency "simplecov".freeze, "~> 0.13".freeze
end
