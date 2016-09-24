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
  ]
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
  spec.rdoc_options = [
    "--main=README.md".freeze,
    "--title=Extensible".freeze,
    "LICENSE.txt".freeze,
    "README.md".freeze,
    "lib/".freeze
  ].freeze
  spec.required_ruby_version = ">= 1.9".freeze

  spec.add_development_dependency "bundler".freeze, "~> 1.13.1".freeze
  spec.add_development_dependency "codeclimate-test-reporter".freeze, "~> 0.6.0".freeze
  spec.add_development_dependency "guard-rspec".freeze, "~> 4.7.3".freeze
  spec.add_development_dependency "guard-rubocop".freeze, "~> 1.2.0".freeze
  spec.add_development_dependency "io-console".freeze, "~> 0.4.6".freeze
  spec.add_development_dependency "pry-byebug".freeze, "~> 3.4.0".freeze
  spec.add_development_dependency "rake".freeze, "~> 11.3.0".freeze
  spec.add_development_dependency "rdoc".freeze, "~> 4.2.2".freeze
  spec.add_development_dependency "ruby_gntp".freeze, "~> 0.3.4".freeze
  spec.add_development_dependency "simplecov".freeze, "~> 0.12.0".freeze
end
