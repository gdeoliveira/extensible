module Extensible
  ##
  # ExtensionKernelTemplate serves as the initial template for all extension kernels that are used internally by
  # Extensible. Each extensible module will extend a clone of ExtensionKernelTemplate that will allow it to execute
  # its own initialization code.
  module ExtensionKernelTemplate
    class << self
      private

      ##
      # call-seq:
      #   initialize_copy(_source) => extension_kernel_template
      #
      # Passes +_source+ to +super+ and overrides the <tt>Module#included</tt> method in order to extend self on
      # including modules.
      #
      # Returns self object.
      def initialize_copy(_source)
        super

        this_kernel = self

        define_method :included do |submodule|
          super submodule
          submodule.extend this_kernel
          self
        end

        private :included

        self
      end
    end

    private

    if RUBY_VERSION >= "1.9".freeze
      def own_const_defined?(mod, name)
        mod.const_defined?(name, false)
      end
    else
      def own_const_defined?(mod, name)
        mod.const_defined?(name)
      end
    end
  end
end
