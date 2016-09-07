require "extensible/extension_kernel"
require "extensible/version"

##
# Use Extensible on your custom extensions in order to get a set of advantages over traditional extensions that override
# the <tt>Module#extended</tt> method directly. When _extending_ Extensible you will be able to define your
# initialization code (similar to using <tt>Module#extended</tt>) via the when_extended method.
#
#   module MyExtension
#     extend Extensible
#     when_extended {|m| puts "#{self} has extended #{m}." }
#   end
#
#   class MyClass
#     extend MyExtension
#   end  #=> MyExtension has extended MyClass.
#
# Extensible is, itself, extensible. This means that you will be able to extend it further or bundle it together with
# other extensible modules by _including_ it in your module.
#
#   module MyExtensibleExtension
#     include Extensible
#
#     def custom_when_extended(&block)
#       puts "Defining initialization code..."
#       when_extended &block
#     end
#   end
#
#   module MyExtension
#     extend MyExtensibleExtension
#     custom_when_extended {|m| puts "#{self} has extended #{m}." }
#   end  #=> Defining initialization code...
#
#   class MyClass
#     extend MyExtension
#   end  #=> MyExtension has extended MyClass.
module Extensible
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
