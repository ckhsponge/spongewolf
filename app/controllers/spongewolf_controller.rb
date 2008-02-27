class SpongewolfController < ApplicationController
  before_filter :init_session
  def sign_in
    if params[:user_name]
      authenticate
      if @spongewolf.signed_in?
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
    @spongewolf.create_account(params)
    authenticate
    if @spongewolf.signed_in?
      redirect_to :action=>'calendars'
      return
    else
      flash.now[:note] = "Unable to sign in"
      render :action=>"sign_in"
    end
  end
  
  def calendars
    @calendars = @spongewolf.calendars
  end
  
  def events
    @calendar_id = params[:calendar_id]
    @events = @spongewolf.events(:calendar_id=>@calendar_id)
  end
  
  def create_event
    @calendar_id = params[:calendar_id]
    @spongewolf.create_event(:calendar_id=>@calendar_id)
    redirect_to :action=>"events",:calendar_id=>@calendar_id
  end
  
  def widget
    @widget_id = params[:id]
    @widget = @spongewolf.widget(:id=>@widget_id)
  end
  
  def widgets
    @calendar_id = params[:calendar_id]
    @widgets = @spongewolf.widgets(:calendar_id=>@calendar_id)
  end
  
  def create_widget
    @calendar_id = params[:calendar_id]
    raise "no calendar id" unless @calendar_id
    @spongewolf.create_widget(:calendar_id=>@calendar_id,:class_name=>params[:class_name])
    redirect_to :action=>"widgets",:calendar_id=>@calendar_id
  end

  def init_session
    session[:spongewolf] ||= {}
    @signed_in = !!session[:spongewolf][:token]
    @spongewolf = Spongewolf::Base.new(:token=>session[:spongewolf][:token])
  end
  
  def authenticate
    session[:spongewolf][:token] = @spongewolf.token(:user_name=>params[:user_name],:password=>params[:password])
  end
end
