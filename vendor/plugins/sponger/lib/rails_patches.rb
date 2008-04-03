puts "Loading rails patches"

#active resource logging
class ActiveResource::Connection
  def http
    unless @http
      @http             = Net::HTTP.new(@site.host, @site.port)
      @http.use_ssl     = @site.is_a?(URI::HTTPS)
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE if @http.use_ssl
      # enable debug http wirelevel dumps
      @http.set_debug_output $stderr
    end

    @http
  end
end

class ActiveResource::Base
  #rails patch http://dev.rubyonrails.org/ticket/8798
  def self.instantiate_collection(collection, prefix_options = {})
    return nil if collection.kind_of?(String) && collection.strip.empty? #ckh
    #puts collection.class.to_s
    #puts collection.to_s
    #puts collection.size.to_s
    #puts collection.keys.inspect if collection && collection.respond_to?('keys')
    collection.delete("total") if collection.is_a?(Hash) && collection["total"] #ckh
    if collection.is_a?(Hash) && collection.size == 1
      value = collection.values.first
      if value.is_a?(Array)
        value.collect! { |record| instantiate_record(record, prefix_options) }
      else
        [ instantiate_record(value, prefix_options) ]
      end
    else
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end
  
  #http://dev.rubyonrails.org/ticket/9529
  def id_from_response(response)
    if responseLocation?
      responseLocation?[/\/([\/]*?)(\.\w+)?$/, 1]
    else
      nil
    end
  end
  
  
  #ckh interpretation of http://dev.rubyonrails.org/ticket/8566
  def load(attributes)
    raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
    @prefix_options, attributes = split_options(attributes)
    attributes.each do |key, value|
      @attributes[key.to_s] =
        case value
          when Array
            resource = find_or_create_resource_for_collection(key)
            #value.map { |attrs| puts "ATTR #{attrs.inspect}";resource.new(attrs) } 
            value.map { |attrs| resource.new(attrs) unless attrs.kind_of? String } #don't continue to unwind data if we get to a string -ckh
          when Hash
            resource = find_or_create_resource_for(key)
            resource.new(value)
          else
            value.dup rescue value
        end
    end
    self
  end
end

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Hash #:nodoc:
      module Conversions
        #strip out time zone data from xml formatting and parsing
        #time will be transmitted and read as UTC although both server and this client store ruby Time in local tz
        XML_FORMATTING.update({"datetime" => Proc.new { |time| time.xmlschema.gsub(/(\-|\+)\d\d?\:\d\d/,'+00:00') }})
        XML_PARSING.update({"datetime"     => Proc.new  { |time|    ::Time.parse(time.gsub(/(\-|\+)\d\d?\:\d\d/,'')) }})
      end
    end
  end
end
