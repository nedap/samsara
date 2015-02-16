require 'samsara'

describe Samsara::Serializer do

  subject{ Samsara::Serializer }

  context ".load" do
    it "does nothing with the value if it is not a hash" do
      arg = nil
      expect(subject.load arg).to eq(nil)
    end

    it "symbolizes the keys of the parsed hash" do
      arg = { "key" => "value" }
      expect(subject.load arg).to eq({ key: "value" })
    end

    it "symbolizes the keys recursively" do
      arg = { "key" => { "key" => "value" } }
      expect(subject.load arg).to eq({ key: { key: "value" } })
    end
  end

  context ".dump" do
    it "does nothing with the value" do
      hash = { key: "value" }
      expect(subject.dump hash).to eq(hash)
    end
  end

end
