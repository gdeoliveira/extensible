module Extensible
  ##
  # Utils contains utility methods whose implementation depends on the currently used Ruby version.
  module Utils
    class << self
      if RUBY_VERSION >= "1.9".freeze
        # :nocov:

        ##
        # call-seq:
        #   own_const_defined?(mod, const_name) => true or false
        #
        # Returns +true+ if constant +const_name+ has been defined in module +mod+ (and not in one of its ancestors).
        # Returns +false+ otherwise.
        def own_const_defined?(mod, const_name)
          mod.const_defined?(const_name, false)
        end
        # :nocov:
      else
        def own_const_defined?(mod, const_name)
          mod.const_defined?(const_name)
        end
      end
    end
  end
end
