class SpongewolfController < ApplicationController
  before_filter :init_session
  def sign_in
    if params[:user_name]
      authenticate
      if @signed_in
        redirect_to :action=>'calendars'
        return
      else
        flash.now[:note] = "Unable to sign in"
      end
    end
  end
  
  def sign_out
    reset_session
    redirect_to :action=>"sign_in"
  end
  
  def create_account
    Sponger::User.create(:user_name=>params[:user_name],:password=>params[:password],:first_name=>params[:first_name],:email=>params[:email])
    authenticate
    if @signed_in
      redirect_to :action=>'calendars'
      return
    else
      flash.now[:note] = "Unable to sign in"
      render :action=>"sign_in"
    end
  end
  
  def calendars
    @calendars = Sponger::Calendar.find(:all)
  end
  
  def events
    @calendar_id = params[:calendar_id]
    @events = Sponger::Event.find(:all,:params=>{:calendar_id=>@calendar_id})
  end
  
  def edit_event
    @calendar_id = params[:calendar_id]
    @event = Sponger::Event.find(params[:id])
  end
  
  def save_event
    @calendar_id = params[:calendar_id]
    @event = Sponger::Event.find(params[:id])
    #@event.load(params[:event])
    @event.title = params[:event][:title]
    @event.start_time = parse_time(params[:event],:start_time)
    @event.end_time = parse_time(params[:event],:end_time)
    @event.tzid = Sponger::TimeZone.tzid_from_human(params[:event][:time_zone])
    @event.description = params[:event][:description]
    @event.all_day = params[:event][:all_day]
    @event.save
    redirect_to :action=>"events",:calendar_id=>@calendar_id
  end
  
  def parse_time(params,key)
    key = key.to_s
    Time.local(params["#{key}(1i)"],params["#{key}(2i)"],params["#{key}(3i)"],params["#{key}(4i)"],params["#{key}(5i)"])
  end
    
  
  def create_event
    @calendar_id = params[:calendar_id]
    Sponger::Event.create(:calendar_id=>@calendar_id,:title=>"Sponger Event",:start_time=>Time.now,:end_time=>Time.now+1.hour)
    redirect_to :action=>"events",:calendar_id=>@calendar_id
  end
  
  def widget
    @widget_id = params[:id]
    @widget = Sponger::Widget.find(@widget_id)
    #puts @widget.inspect
    #puts @widget.colors.inspect
  end
  
  def widgets
    @calendar_id = params[:calendar_id]
    @widgets = Sponger::Widget.find(:all,:calendar_id=>@calendar_id)
  end
  
  def create_widget
    @calendar_id = params[:calendar_id]
    raise "no calendar id" unless @calendar_id
    Sponger::Widget.create(:calendar_id=>@calendar_id,:class_name=>params[:class_name])
    redirect_to :action=>"widgets",:calendar_id=>@calendar_id
  end

  def init_session
    Sponger::Resource.clear_private_data
    @signed_in = !!session[:spongewolf_token]
    Sponger::Resource.token = Sponger::AuthorizationToken.new(:value=>session[:spongewolf_token]) if session[:spongewolf_token]
  end
  
  def authenticate
    token = Sponger::AuthorizationToken.create(:user_name=>params[:user_name],:password=>params[:password])
    if token && token.respond_to?('value') && token.value
      @signed_in = true
      session[:spongewolf_token] = token.value
    end
  end
end
