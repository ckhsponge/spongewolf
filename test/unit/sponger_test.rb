require File.dirname(__FILE__) + '/../test_helper'

class SpongerTest < Test::Unit::TestCase
  def setup
    #token = Sponger::AuthorizationToken.create(:user_name=>"spongewolf@spongecell.com",:password=>"wolfy")
    token = Sponger::AuthorizationToken.create(:user_name=>"purpose",:password=>"zzzz")
    #puts "t: #{token.body.class} #{token.inspect} #{token.to_hash.inspect} #{token.to_param.inspect}"
    #puts "body: #{Hash.create_from_xml(token.body).inspect}"
    assert token
    assert token.value
  end
  def test_calendar
    calendars = Sponger::Calendar.find(:all)
    puts calendars.inspect
    assert calendars
    assert calendars[0]
    assert calendars[0].id
    
    calendar = Sponger::Calendar.find(calendars[0].id)
    assert calendar
    
    events = Sponger::Event.find(:all,:params=>{:calendar_id=>calendars[0].id})
    assert events
    assert events[0]
    assert events[0].id
    
  end
  
  def test_event
    
    time = Time.now
    event = Sponger::Event.new(:title=>"Test Event Zero",:start_time=>Time.now.to_s,:tzid=>"ETC/Utc")
    assert event
    puts "event: #{event.inspect}"
    puts "attr: #{event.attributes.inspect}"
    puts "attr xml: #{event.to_xml}"
    event.save
    
    assert event.start_time
    puts "start_time #{event.start_time}"
    assert_equal time.hour,event.start_time.hour
    assert_equal time.min,event.start_time.min
    
    event.title = "Test Event One"
    event.save
    
    event1 = Sponger::Event.find(event.id)
    assert_equal event.title,event1.title
    
    
    time = Time.now
    tzoffset = Time.now.dst? ? -4 : -5
    event = Sponger::Event.new(:title=>"Test Event Two",:start_time=>Time.now.to_s,:tzid=>"America/New_York")
    assert event
    puts "event: #{event.inspect}"
    puts "attr: #{event.attributes.inspect}"
    puts "attr xml: #{event.to_xml}"
    event.save
    
    puts event.methods.sort.inspect
    assert event.start_time
    puts "start_time #{event.start_time}"
    assert_equal time.hour,event.start_time.hour
    assert_equal time.min,event.start_time.min
    
    event.title = "Test Event Three"
    event.save
    
    assert_equal "Test Event Three",event.title
    puts "start_time #{event.start_time}"
    assert_equal time.hour,event.start_time.hour
    assert_equal time.min,event.start_time.min
    
    event3 = Sponger::Event.find(event.id)
    assert_equal "Test Event Three",event3.title
    puts "start_time #{event3.start_time}"
    assert_equal time.hour,event3.start_time.hour
    assert_equal time.min,event3.start_time.min
    
    event3.title = "Test Event Four"
    event3.save
    
    event4 = Sponger::Event.find(event3.id)
    assert_equal "Test Event Four",event4.title
    puts "start_time #{event4.start_time}"
    assert_equal time.hour,event4.start_time.hour
    assert_equal time.min,event4.start_time.min
    
  end
end