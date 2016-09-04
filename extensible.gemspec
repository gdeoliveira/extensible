# coding: utf-8
lib = File.expand_path("../lib".freeze, __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "extensible/version".freeze

Gem::Specification.new do |spec|
  spec.author = "Gabriel de Oliveira".freeze
  spec.files = Dir[
    "*.gemspec".freeze,
    "LICENSE.*".freeze,
    "README.*".freeze,
    "lib/**/*.rb".freeze
  ].freeze
  spec.name = "extensible".freeze
  spec.summary = "Ruby extensions made easy.".freeze
  spec.version = Extensible::VERSION

  spec.email = "deoliveira.gab@gmail.com".freeze
  spec.homepage = "https://github.com/gdeoliveira/extensible".freeze
  spec.license = "MIT".freeze

  spec.description = <<-EOS.freeze
Use Extensible on your custom extensions in order to get a set of advantages over traditional extensions that override
the Module#extended method directly.
  EOS
  spec.required_ruby_version = ">= 1.9".freeze

  spec.add_development_dependency "bundler".freeze
  spec.add_development_dependency "codeclimate-test-reporter".freeze
  spec.add_development_dependency "guard-rspec".freeze
  spec.add_development_dependency "guard-rubocop".freeze
  spec.add_development_dependency "io-console".freeze
  spec.add_development_dependency "pry-byebug".freeze
  spec.add_development_dependency "rake".freeze
  spec.add_development_dependency "ruby_gntp".freeze
  spec.add_development_dependency "simplecov".freeze
end
