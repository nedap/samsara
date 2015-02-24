class Samsara::Serializer

  def self.dump(arg)
    case arg
    when Hash
      arg.to_json
    else
      arg
    end
  end

  def self.load(arg)
    case arg
    when String
      load JSON.parse(arg)
    when Hash
      symbolize_keys! arg
    else
      arg
    end
  end

  def self.symbolize_keys!(arg)
    return arg unless arg.is_a? Hash
    arg.values.each{|val| symbolize_keys! val }
    arg.symbolize_keys!
  end

end
