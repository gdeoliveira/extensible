require "spec_helper"

describe Extensible::Error do
  subject { described_class.constants.map {|c| described_class.const_get c } }

  it { is_expected.to all(be_frozen) }
end
