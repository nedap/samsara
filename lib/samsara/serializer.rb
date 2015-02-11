class Samsara::Serializer

  def self.dump(hash)
    hash.to_json
  end

  def self.load(string)
    return {} if string.blank?
    symbolize_keys! JSON.parse(string)
  end

  def self.symbolize_keys!(arg)
    return arg unless arg.is_a? Hash
    arg.values.each{|val| symbolize_keys! val }
    arg.symbolize_keys!
  end

end
