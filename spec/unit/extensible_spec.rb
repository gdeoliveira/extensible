# frozen_string_literal: true

require "extensible"

describe Extensible do
  context "#when_extended" do
    it "raises an error if code block is not provided" do
      m = Module.new

      expect do
        m.module_eval do
          extend Extensible
          when_extended
        end
      end.to raise_error(LocalJumpError)
    end
  end

  context "hierarchy" do
    let(:extensible_base_extension_1) do
      Module.new.tap do |m|
        m.module_eval do
          include Extensible
        end
      end
    end

    let(:extensible_base_extension_2) do
      Module.new.tap do |m|
        m.module_eval do
          include Extensible
          extend Extensible
          when_extended do |sm|
            sm.const_set(:EBE_2_CALLED, true)
          end
        end
      end
    end

    let(:extensible_sub_extension) do
      ebe_1 = extensible_base_extension_1
      ebe_2 = extensible_base_extension_2
      Module.new.tap do |m|
        m.module_eval do
          include ebe_1
          include ebe_2
        end
      end
    end

    let(:base_extension_1) do
      ese = extensible_sub_extension
      Module.new.tap do |m|
        m.module_eval do
          extend ese
          when_extended do |sm|
            sm.const_set(:BE_1_CALLED, true)
          end
        end
      end
    end

    let(:base_extension_2) do
      ebe_1 = extensible_base_extension_1
      Module.new.tap do |m|
        m.module_eval do
          extend ebe_1
          when_extended do |sm|
            sm.const_set(:BE_2_CALLED, true)
          end
        end
      end
    end

    let(:sub_extension) do
      be_1 = base_extension_1
      be_2 = base_extension_2
      Module.new.tap do |m|
        m.module_eval do
          include be_1
          include be_2
        end
      end
    end

    subject do
      se = sub_extension
      Class.new.tap do |c|
        c.class_eval do
          extend se
        end
      end
    end

    def extension_ids(mod)
      class << mod
        self
      end.ancestors.map(&:object_id)
    end

    it "adds the extensible extension kernel to all extensible extensions" do
      expect(extension_ids(Extensible)).to include(Extensible::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_1)).to include(Extensible::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_2)).to include(Extensible::ExtensionKernel.object_id)
      expect(extension_ids(extensible_sub_extension)).to include(Extensible::ExtensionKernel.object_id)
    end

    it "does not add the extensible extension kernel to non-extensible extensions" do
      expect(extension_ids(base_extension_1)).not_to include(Extensible::ExtensionKernel.object_id)
      expect(extension_ids(base_extension_2)).not_to include(Extensible::ExtensionKernel.object_id)
      expect(extension_ids(sub_extension)).not_to include(Extensible::ExtensionKernel.object_id)
      expect(extension_ids(subject)).not_to include(Extensible::ExtensionKernel.object_id)
    end

    it "adds the `extensible_base_extension_2` extension kernel to modules that include it" do
      expect(extension_ids(extensible_base_extension_2)).to \
        include(extensible_base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(extensible_sub_extension)).to include(extensible_base_extension_2::ExtensionKernel.object_id)
    end

    it "does not add the `extensible_base_extension_2` extension kernel to modules that do not include it" do
      expect(extension_ids(Extensible)).not_to include(extensible_base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_1)).not_to \
        include(extensible_base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(base_extension_1)).not_to include(extensible_base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(base_extension_2)).not_to include(extensible_base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(sub_extension)).not_to include(extensible_base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(subject)).not_to include(extensible_base_extension_2::ExtensionKernel.object_id)
    end

    it "adds the `base_extension_1` extension kernel to modules that include it" do
      expect(extension_ids(base_extension_1)).to include(base_extension_1::ExtensionKernel.object_id)
      expect(extension_ids(sub_extension)).to include(base_extension_1::ExtensionKernel.object_id)
    end

    it "does not add the `base_extension_1` extension kernel to modules that do not include it" do
      expect(extension_ids(Extensible)).not_to include(base_extension_1::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_1)).not_to include(base_extension_1::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_2)).not_to include(base_extension_1::ExtensionKernel.object_id)
      expect(extension_ids(extensible_sub_extension)).not_to include(base_extension_1::ExtensionKernel.object_id)
      expect(extension_ids(base_extension_2)).not_to include(base_extension_1::ExtensionKernel.object_id)
      expect(extension_ids(subject)).not_to include(base_extension_1::ExtensionKernel.object_id)
    end

    it "adds the `base_extension_2` extension kernel to modules that include it" do
      expect(extension_ids(base_extension_2)).to include(base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(sub_extension)).to include(base_extension_2::ExtensionKernel.object_id)
    end

    it "does not add the `base_extension_2` extension kernel to modules that do not include it" do
      expect(extension_ids(Extensible)).not_to include(base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_1)).not_to include(base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(extensible_base_extension_2)).not_to include(base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(extensible_sub_extension)).not_to include(base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(base_extension_1)).not_to include(base_extension_2::ExtensionKernel.object_id)
      expect(extension_ids(subject)).not_to include(base_extension_2::ExtensionKernel.object_id)
    end

    it "executes the `extensible_base_extension_2` extension code on modules that extend it" do
      expect(base_extension_1.const_defined?(:EBE_2_CALLED, false)).to be(true)
    end

    it "does not execute `extensible_base_extension_2` extension code on modules that do not extend it" do
      expect(Extensible.const_defined?(:EBE_2_CALLED, false)).to be(false)
      expect(extensible_base_extension_1.const_defined?(:EBE_2_CALLED, false)).to be(false)
      expect(extensible_base_extension_2.const_defined?(:EBE_2_CALLED, false)).to be(false)
      expect(extensible_sub_extension.const_defined?(:EBE_2_CALLED, false)).to be(false)
      expect(base_extension_2.const_defined?(:EBE_2_CALLED, false)).to be(false)
      expect(sub_extension.const_defined?(:EBE_2_CALLED, false)).to be(false)
      expect(subject.const_defined?(:EBE_2_CALLED, false)).to be(false)
    end

    it "executes the `base_extension_1` extension code on modules that extend it" do
      expect(subject.const_defined?(:BE_1_CALLED, false)).to be(true)
    end

    it "does not execute `base_extension_1` extension code on modules that do not extend it" do
      expect(Extensible.const_defined?(:BE_1_CALLED, false)).to be(false)
      expect(extensible_base_extension_1.const_defined?(:BE_1_CALLED, false)).to be(false)
      expect(extensible_base_extension_2.const_defined?(:BE_1_CALLED, false)).to be(false)
      expect(extensible_sub_extension.const_defined?(:BE_1_CALLED, false)).to be(false)
      expect(base_extension_1.const_defined?(:BE_1_CALLED, false)).to be(false)
      expect(base_extension_2.const_defined?(:BE_1_CALLED, false)).to be(false)
      expect(sub_extension.const_defined?(:BE_1_CALLED, false)).to be(false)
    end

    it "executes the `base_extension_2` extension code on modules that extend it" do
      expect(subject.const_defined?(:BE_2_CALLED, false)).to be(true)
    end

    it "does not execute `base_extension_2` extension code on modules that do not extend it" do
      expect(Extensible.const_defined?(:BE_2_CALLED, false)).to be(false)
      expect(extensible_base_extension_1.const_defined?(:BE_2_CALLED, false)).to be(false)
      expect(extensible_base_extension_2.const_defined?(:BE_2_CALLED, false)).to be(false)
      expect(extensible_sub_extension.const_defined?(:BE_2_CALLED, false)).to be(false)
      expect(base_extension_1.const_defined?(:BE_2_CALLED, false)).to be(false)
      expect(base_extension_2.const_defined?(:BE_2_CALLED, false)).to be(false)
      expect(sub_extension.const_defined?(:BE_2_CALLED, false)).to be(false)
    end
  end
end
