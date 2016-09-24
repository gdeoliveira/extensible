# frozen_string_literal: true

require "extensible/utils"

RSpec::Matchers.define :have_own_constant_defined do |constant|
  match {|mod| Extensible::Utils.own_const_defined?(mod, constant) }
end
