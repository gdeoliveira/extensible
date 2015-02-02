require "extensible/extension_kernel_template"

module Extensible # rubocop:disable Style/Documentation
  ExtensionKernel = ExtensionKernelTemplate.clone.module_eval do
    private # rubocop:disable Style/EmptyLinesAroundAccessModifier

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
