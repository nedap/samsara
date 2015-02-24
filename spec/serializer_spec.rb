require 'samsara'

describe Samsara::Serializer do

  subject{ Samsara::Serializer }

  context ".load" do
    it "does nothing with a nil value" do
      arg = nil
      expect(subject.load arg).to eq nil
    end

    it "symbolizes the keys of a hash argument" do
      arg = { "key" => "value" }
      expect(subject.load arg).to eq({ key: "value" })
    end

    it "symbolizes the keys of a hash argument recursively" do
      arg = { "key" => { "key" => "value" } }
      expect(subject.load arg).to eq({ key: { key: "value" } })
    end

    it "parses a string value to json" do
      arg = { key: "value" }.to_json
      expect(subject.load arg).to eq({ key: "value" })
    end
  end

  context ".dump" do
    it "converts a hash argument to json" do
      hash = { key: "value" }
      expect(subject.dump hash).to eq(hash.to_json)
    end

    it "does nothing with a string argument" do
      str = { key: "value" }.to_json
      expect(subject.dump str).to eq(str)
    end
  end

end
