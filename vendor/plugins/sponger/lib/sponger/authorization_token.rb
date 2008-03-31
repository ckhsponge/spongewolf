class Sponger::AuthorizationToken < Sponger::Resource
  #require 'cgi' 
  #require 'action_controller/vendor/xml_simple' 
  #require 'action_controller/vendor/xml_node'
  #self.site = "http://spongecell.com/api"
  def self.create(options = {})
    prefix_options, query_options = split_options(options)
    #"#{prefix(prefix_options)}#{collection_name}/#{method_name}.xml#{query_string(query_options)}"
    s = "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
    c = connection.post(s, '', headers)
    h = Hash.from_xml c.body
    #puts h.inspect
    
    self.token = Sponger::AuthorizationToken.new(h['authorization_token'])
    return self.token
  end
end
