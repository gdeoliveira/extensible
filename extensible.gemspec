# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "extensible/version"

Gem::Specification.new do |spec|
  spec.name = "extensible"
  spec.version = Extensible::VERSION
  spec.authors = ["Gabriel de Oliveira"]
  spec.email = ["deoliveira.gab@gmail.com"]
  spec.summary = "Create extensible extensions."
  spec.description = "Create extensible extensions."
  spec.homepage = "https://github.com/gdeoliveira/extensible"
  spec.license = "MIT"
  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^spec\//)
  spec.require_paths = ["lib"]
  spec.rdoc_options << "--title=Extensible"
end
