require "extensible/extension_kernel"
require "extensible/version"

module Extensible # rubocop:disable Style/Documentation
  extend ExtensionKernel

  private

  def when_extended(&b)
    fail unless block_given?

    self::ExtensionKernel.module_eval do
      define_method :extended do |submodule|
        super(submodule)
        b.call(submodule)
        self
      end

      private :extended
    end

    self
  end
end
