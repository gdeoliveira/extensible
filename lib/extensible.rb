require "extensible/extension_kernel"
require "extensible/version"

module Extensible # rubocop:disable Style/Documentation
  extend ExtensionKernel

  private

  ##
  # call-seq:
  #   when_extended() {|extended_module| ... } => module
  #
  # The +when_extended+ method accepts a code block that will be executed every time this module is extended in a
  # manner similar to <tt>Module#extended</tt>. The code block will be passed an +extended_module+ parameter containing
  # the module that is being extended. There is no need to make explicit calls to +super+ as those will be made
  # internally by Extensible.
  #
  # Returns self (this module).
  def when_extended
    raise LocalJumpError, "no block given".freeze unless block_given?

    self::ExtensionKernel.module_eval do
      define_method :extended do |submodule|
        super submodule
        yield submodule
        self
      end

      private :extended
    end

    self
  end
end
