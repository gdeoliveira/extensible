require "extensible/extension_kernel_template"

module Extensible
  ##
  # A custom ExtensionKernelTemplate clone that is extended by Extensible to make it, well, extensible.
  ExtensionKernel = ExtensionKernelTemplate.clone.module_eval do
    private

    def extended(submodule)
      super

      unless submodule.const_defined?(:ExtensionKernel, false)
        kernel = ExtensionKernelTemplate.clone
        submodule.const_set(:ExtensionKernel, kernel)
        submodule.extend kernel
      end

      self
    end

    self
  end
end
