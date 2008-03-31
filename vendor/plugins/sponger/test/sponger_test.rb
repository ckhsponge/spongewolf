require 'test/unit'
require 'sponger'

class SpongerTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_session
    session = Sponger::Session.new
    event = session.new_event
    assert event
    puts event.inspect
    assert event.facebook_add_url
    assert !event.facebook_add_url.empty?
    assert !event.title
  end
  
  def test_sign_in
    Sponger::Event.ttt="bye"
    Sponger::XmlRecord.ttt="hi"
    assert_equal "hi",Sponger::Event.ttt
  end
end
