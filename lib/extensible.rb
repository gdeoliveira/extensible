require "extensible/constants"
require "extensible/extension_kernel"
require "extensible/version"

module Extensible # rubocop:disable Style/Documentation
  extend ExtensionKernel

  private

  ##
  # call-seq:
  #   when_extended() {|module| ... } => self
  #
  # The +when_extended+ method accepts a code block that will be executed every time this module is extended in a
  # manner similar to <tt>Module#extended</tt>. The code block will be passed a +module+ parameter containing the module
  # that is being extended. There is no need to make explicit calls to +super+ as those will be made internally by
  # Extensible.
  #
  # Returns self object.
  def when_extended(&b)
    fail(ArgumentError, Error::BLOCK_NOT_GIVEN) unless block_given?

    self::ExtensionKernel.module_eval do
      define_method :extended do |submodule|
        super submodule
        b.call submodule
        self
      end

      private :extended
    end

    self
  end
end
