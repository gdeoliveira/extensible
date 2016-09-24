module Extensible
  module Utils
    class << self
      if RUBY_VERSION < "1.9".freeze
        def own_const_defined?(mod, name)
          mod.const_defined?(name)
        end
      else
        def own_const_defined?(mod, name)
          mod.const_defined?(name, false)
        end
      end
    end
  end
end
