# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "extensible/version"

Gem::Specification.new do |spec|
  spec.name = "extensible"
  spec.version = Extensible::VERSION
  spec.authors = ["Gabriel de Oliveira"]
  spec.email = ["deoliveira.gab@gmail.com"]
  spec.summary = "Ruby extensions made easy."
  spec.description = "Use Extensible on your custom extensions in order to get the following set of advantages over" \
                     "traditional extensions that override the `Module#extended` method directly:\n\n" \
                     "- Calls to `super` are handled internally to ensure all your _extensible_ extensions are" \
                     "properly initialized.\n" \
                     "- Your _extensible_ extensions will be automatically able to become the base of other, more" \
                     "specific extensions while proper initialization is maintained by simply including them.\n" \
                     "- Bundle several _extensible_ extensions in a single module by including them and they will all" \
                     "be correctly initialized when extending the bundler module."
  spec.homepage = "https://github.com/gdeoliveira/extensible"
  spec.license = "MIT"
  spec.files = `git ls-files -z`.split("\x0")
  spec.test_files = spec.files.grep(/^spec\//)
  spec.require_paths = ["lib"]
  spec.rdoc_options << "--title=Extensible"
end
