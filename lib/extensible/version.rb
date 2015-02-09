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
  ##
  # Current version of Extensible.
  VERSION = "0.0.1"
end
