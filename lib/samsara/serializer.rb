class Samsara::Serializer

  def self.dump(hash)
    hash
  end

  def self.load(hash)
    return hash unless hash.is_a? Hash
    symbolize_keys! hash
  end

  def self.symbolize_keys!(arg)
    return arg unless arg.is_a? Hash
    arg.values.each{|val| symbolize_keys! val }
    arg.symbolize_keys!
  end

end
