module Extensible
  ##
  # TODO: Write documentation.
  module ExtensionKernelTemplate
    class << self
      private

      def initialize_copy(_source)
        super

        this_kernel = self

        define_method :included do |submodule|
          super(submodule)
          submodule.extend this_kernel
          self
        end

        private :included

        self
      end
    end
  end
end
