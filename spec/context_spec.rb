require 'rails_helper'

describe Samsara::Context do

  let(:celebrity_params) do
    { first_name: "Neil", last_name: "Harris" }
  end

  let(:params) do
    { celebrity: celebrity_params, controller: "celebrities", action: "create" }
  end

  let(:event_attributes) do
    { method: "POST", url: "/celebrities", params: params }
  end

  let(:event) do
    Samsara::HttpRequest.new(event_attributes)
  end

  let(:context_attributes) do
    { environment_name: "test", application_name: "Dummy", event: event }
  end

  before { Samsara::Context.create context_attributes }
  subject { Samsara::Context.first }

  describe "#event_attributes" do
    it "is serialized using the Samsara::Serializer" do
      allow(Samsara::Serializer).to receive(:dump).with(any_args)
      expect(Samsara::Serializer).to receive(:dump).with(event_attributes)
      subject.event_attributes = event_attributes
    end

    it "is deserialized using the Samsara::Serializer" do
      allow(Samsara::Serializer).to receive(:load).with(any_args)
      expect(Samsara::Serializer).to receive(:load).with(event_attributes.to_json)
      subject.event_attributes
    end
  end

end
