require 'rails_helper'

describe Samsara::Revision do

  let(:original_attributes) do
    { changed: "unchanged", added: nil }
  end

  let(:modified_attributes) do
    { unchanged: "unchanged", changed: "changed", added: "added" }
  end

  let(:revision_attributes) do
    { modified_attributes: modified_attributes, original_attributes: original_attributes }
  end

  before { Samsara::Revision.create revision_attributes }
  subject { Samsara::Revision.first }

  describe "#original_attributes" do
    it "is serialized using the Samsara::Serializer" do
      allow(Samsara::Serializer).to receive(:dump).with(any_args)
      expect(Samsara::Serializer).to receive(:dump).with(original_attributes)
      subject.original_attributes = original_attributes
    end

    it "is deserialized using the Samsara::Serializer" do
      allow(Samsara::Serializer).to receive(:load).with(any_args)
      expect(Samsara::Serializer).to receive(:load).with(original_attributes.to_json)
      subject.original_attributes
    end
  end

  describe "#modified_attributes" do
    it "is serialized using the Samsara::Serializer" do
      allow(Samsara::Serializer).to receive(:dump).with(any_args)
      expect(Samsara::Serializer).to receive(:dump).with(modified_attributes)
      subject.modified_attributes = modified_attributes
    end

    it "is deserialized using the Samsara::Serializer" do
      allow(Samsara::Serializer).to receive(:load).with(any_args)
      expect(Samsara::Serializer).to receive(:load).with(modified_attributes.to_json)
      subject.modified_attributes
    end
  end

  describe "#attribute_changes" do
    it "does not include unchanged attributes" do
      expect(subject.attribute_changes).to_not include(:unchanged)
    end

    it "includes the changed attributes" do
      expect(subject.attribute_changes).to include(:changed)
      expect(subject.attribute_changes[:changed]).to eq ["unchanged", "changed"]
    end

    it "includes attributes given a value" do
      expect(subject.attribute_changes).to include(:added)
      expect(subject.attribute_changes[:added]).to eq [nil, "added"]
    end
  end

end
