class Sponger::Resource < ActiveResource::Base
  #production host:
  HOST = "http://spongecell.com"
  #HOST = "http://calf.spongecell.com"
  #HOST = "http://127.0.0.1:3001"
  self.site = "#{HOST}/api"
  
  @@token = nil
  def self.token
    @@token
  end
  def self.token=t
    @@token = t
  end
  
  def self.clear_private_data
    @@token = nil
  end
  
  def self.collection_path(prefix_options = {}, query_options = nil)
         prefix_options, query_options = split_options(prefix_options) if query_options.nil?
         query_options ||= {}
         query_options[:token] = self.token.value if self.token
         puts "query_options #{query_options.inspect}"
         "#{prefix(prefix_options)}#{collection_name}.#{format.extension}#{query_string(query_options)}"
  end
  
  def self.element_path(id, prefix_options = {}, query_options = nil)
         prefix_options, query_options = split_options(prefix_options) if query_options.nil?
         query_options ||= {}
         query_options[:token] = self.token.value if self.token
         puts "query_options #{query_options.inspect}"
         "#{prefix(prefix_options)}#{collection_name}/#{id}.#{format.extension}#{query_string(query_options)}"
  end
  
#  def self.post(method_name, options = {}, body = '')
#    puts "BODY #{body}"
#             connection.post(custom_method_collection_url(method_name, options), body, headers)
#  end
    
#  def self.find(*arguments)
#    scope   = arguments.slice!(0)
#    options = arguments.slice!(0) || {}
#    options[:params] ||= {}
#    options[:params][:token] = self.token.value if self.token
#    puts "options #{options.inspect}"
#    case scope
#      when :all   then find_every(options)
#      when :first then find_every(options).first
#      when :one   then find_one(options)
#      else             find_single(scope, options)
#    end
#  end
end
