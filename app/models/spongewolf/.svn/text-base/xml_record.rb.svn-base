class Spongewolf::XmlRecord
  def initialize(record_element=nil)
    @hash = {}
    
    return unless record_element
    record_element.each_element { |element|
      @hash[element.name] = element.text
    }
  end
  
  def id
    @hash["id"]
  end
  
  def inspect
    @hash.inspect
  end
  
  def hash=(h)
    @hash = h
  end
  
  def method_missing(*args)
    if args && args.size>0 && @hash.has_key?(args[0].to_s)
      return @hash[args[0].to_s]
    else
      super(*args)
    end
  end
end