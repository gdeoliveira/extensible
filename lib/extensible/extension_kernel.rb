require "extensible/extension_kernel_template".freeze
require "extensible/utils".freeze

module Extensible
  ##
  # A custom ExtensionKernelTemplate clone that is extended by Extensible to make it, well, extensible.
  ExtensionKernel = ExtensionKernelTemplate.clone.module_eval do
    private

    def extended(submodule)
      raise_type_error_if_submodule_is_not_a_module(submodule)

      super

      unless Utils.own_const_defined?(submodule, :ExtensionKernel)
        kernel = ExtensionKernelTemplate.clone
        submodule.const_set(:ExtensionKernel, kernel)
        submodule.extend kernel
      end

      self
    end

    def raise_type_error_if_submodule_is_not_a_module(submodule)
      return if submodule.class == Module
      raise TypeError, "expected to extend object of type `Module` with module `#{name}`, got `#{submodule.class}` " \
                       "instead"
    end

    self
  end
end
