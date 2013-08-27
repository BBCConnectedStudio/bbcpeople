class UsersController < ApplicationController

  before_filter :set_user, :except => [:index]

  def index
    @users = User.all
  end

  def show
    @articles = ::Juicer.articles_related_to(@entities)
    @tv_programmes = ::Programmes.find_programmes(@entities, :tv)
    @radio_programmes = ::Programmes.find_programmes(@entities, :radio)

    @upcoming_radio_programmes = ::Programmes.find_upcoming_programmes(@entities, :radio)
    @upcoming_tv_programmes = ::Programmes.find_upcoming_programmes(@entities, :tv)
  end

  def read
    @articles = ::Juicer.articles_related_to(@entities)

    respond_to do |format|
      format.html { render 'profiles/read' }
      format.rss {
        @title = "News feed for #{@user.twitter_handle}"
        @description = "The latest news."
        @link = user_url(@user)
        render 'profiles/read_rss', :layout => false
      }
    end
  end

  def listen
    @programme_type = 'radio'
    @programmes = ::Programmes.find_programmes(@entities, :radio)

    respond_to do |format|
      format.html { render 'profiles/programme' }
      format.rss {
        @title = "Radio feed for #{@user.twitter_handle}"
        @description = "The latest radio programmes."
        @link = user_url(@user)
        render 'profiles/programme_rss', :layout => false
      }
    end
  end

  def listen_all
    @programme_type = 'radio'
    @programmes = ::Programmes.find_programmes(@entities, :radio)
    @upcoming_programmes = ::Programmes.find_upcoming_programmes(@entities, :radio)

    render 'profiles/all_programmes'
  end

  def watch_all
    @programme_type = 'tv'
    @programmes = ::Programmes.find_programmes(@entities, :tv)
    @upcoming_programmes = ::Programmes.find_upcoming_programmes(@entities, :tv)

    render 'profiles/all_programmes'
  end

  def watch
    @programme_type = 'tv'
    @programmes = ::Programmes.find_programmes(@entities, :tv)

    respond_to do |format|
      format.html { render 'profiles/programme' }
      format.rss {
        @title = "TV feed for #{@user.twitter_handle}"
        @description = "The latest TV programmes."
        @link = user_url(@user)
        render 'profiles/programme_rss', :layout => false
      }
    end
  end

  def radio_schedules
    @programme_type = 'radio'
    @programmes = ::Programmes.find_upcoming_programmes(@entities, :radio)
    calendar = Programme.calendar(@programmes)

     respond_to do |format|
       format.ics do
         headers['Content-Type'] = "text/calendar; charset=UTF-8"
         render :text => calendar.to_ical, :layout => false
       end
       format.html { render 'profiles/upcoming_programmes' }
     end
  end

  def tv_schedules
    @programme_type = 'tv'
    @programmes = ::Programmes.find_upcoming_programmes(@entities, :tv)
    calendar = Programme.calendar(@programmes)

     respond_to do |format|
       format.ics do
         headers['Content-Type'] = "text/calendar; charset=UTF-8"
         render :text => calendar.to_ical, :layout => false
       end
       format.html { render 'profiles/upcoming_programmes' }
     end
  end

  private
  def set_user
    unless params[:id].blank?
      @user = User.find_by_twitter_handle(params[:id]) || not_found
      @entities = @user.followings_as_entities
    end
  end
end
