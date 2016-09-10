# frozen_string_literal: true

require "support/matchers/be_a_semantic_version"
require "extensible/version"

describe Extensible::VERSION do
  it { is_expected.to be_a_semantic_version }
  it { is_expected.to be_frozen }
end
