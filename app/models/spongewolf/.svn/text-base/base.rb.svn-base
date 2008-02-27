class Spongewolf::Base
  HOST = 'http://spongecell.com'
  #HOST = 'http://127.0.0.1:3001'
  
  def initialize(args)
    @token = args[:token]
  end
  
  def signed_in?
    !!@token
  end
  
  def token(args)
    @token = nil
    xml_data = post('/api/authorization_tokens',:user_name=>args[:user_name],:password=>args[:password])
    doc = REXML::Document.new(xml_data)
    puts doc.inspect
    
    elements = doc.get_elements("authorization_token/value").first
    @token = elements.text if elements
    puts "token: #{@token}"
    return @token
  end
  
  def create_account(args)
    xml_data = post('/api/users',:user_name=>args[:user_name],:password=>args[:password],:first_name=>args[:first_name],:email=>args[:email])
    puts xml_data.inspect
    doc = REXML::Document.new(xml_data)
    puts doc.inspect
    
  end
  
  def calendars
    
    xml_data = get "/api/calendars"
    puts xml_data.inspect
    doc = REXML::Document.new(xml_data)
    puts doc.inspect
    
    results = []
    doc.each_element("calendars/calendar") do |calendar_element|
      results << Spongewolf::Calendar.new(calendar_element)
    end
    return results
  end
  
  def events(args)
    # get the XML data as a string
    xml_data = get "/api/events",:calendar_id=>args[:calendar_id]
    doc = REXML::Document.new(xml_data)
    puts doc
    
    results = []
    doc.each_element("events/event") do |event_element|
      results << Spongewolf::Event.new(event_element)
    end
    return results
  end
  
  def create_event(args)
    response = post "/api/events",:calendar_id=>args[:calendar_id],:title=>"New Event",:start_time=>Time.now.to_s
    #response = post_data "/api/widgets",doc.to_s
    puts response
  end
  
  def widgets(args)
    # get the XML data as a string
    xml_data = get "/api/widgets" #,:calendar_id=>args[:calendar_id]
    doc = REXML::Document.new(xml_data)
    puts doc
    
    results = []
    doc.each_element("widgets/widget") do |element|
      results << Spongewolf::Widget.new(element)
    end
    results = results.delete_if{|w| w.calendar_id!=args[:calendar_id]} if args[:calendar_id]
    return results
  end
  
  def widget(args)
    xml_data = get "/api/widgets/#{args[:id]}"
    element = REXML::Document.new(xml_data).get_elements("widget").first
    return Spongewolf::Widget.new(element)
  end
  
  def create_widget(args)
    xml_data = get "/api/widgets/new" #,:calendar_id=>args[:calendar_id]
    doc = REXML::Document.new(xml_data)
    puts doc
    
    puts args[:calendar_id]
    doc.each_element("widget/calendar_id") do |element|
      element.text = args[:calendar_id]
    end
    puts doc.to_s
    
    response = post "/api/widgets",:calendar_id=>args[:calendar_id],:title=>"Widget for cal #{args[:calendar_id]}",:class_name=>args[:class_name]
    #response = post_data "/api/widgets",doc.to_s
    puts response
  end
  
  def get(url,args={})
    args["token"] = @token if @token
    url = HOST+url
    if args.size>0
      args.each_key do |key|
        url += url.include?("?") ? "&" : "?"
        url += "#{CGI.escape key.to_s}=#{CGI.escape args[key].to_s}"
      end
    end
    puts "get: #{url}"
    puts "get: #{URI.parse(url).inspect}"
    return Net::HTTP.get_response(URI.parse(url)).body
  end
  
  def post(url,args={})
    args["token"] = @token if @token
    url = HOST + url
    puts "posting data: #{args.inspect}"
    return Net::HTTP.post_form(URI.parse(url),args).body
  end
  
  def post_data(url,data)
    #url = HOST + url
    http = Net::HTTP.start("http://127.0.0.1",3001)
    puts http.inspect
    return http.post(url,data).body
  end
end
