# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "extensible/version"

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 1.9"
  spec.name = "extensible"
  spec.version = Extensible::VERSION
  spec.authors = ["Gabriel de Oliveira"]
  spec.email = ["deoliveira.gab@gmail.com"]
  spec.summary = "Ruby extensions made easy."
  spec.description = <<-EOS
Use Extensible on your custom extensions in order to get a set of advantages over traditional extensions that override
the Module#extended method directly.
  EOS
  spec.homepage = "https://github.com/gdeoliveira/extensible"
  spec.license = "MIT"
  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^spec\//)
  spec.require_paths = ["lib"]
  spec.rdoc_options << "--title=Extensible"
end
