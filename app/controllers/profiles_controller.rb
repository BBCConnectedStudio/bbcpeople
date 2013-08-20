class ProfilesController < ApplicationController
  include ApplicationHelper

  before_filter :set_person, :except => [:index, :edit, :update]
  before_filter :authorize_admin!, :only => [:edit, :update]

  def index
   @people = ::Juicer.trending_people
   @max_score = @people.first.cooccurence_count
   @page_title = 'People'
  end

  def edit
   @entity = Entity.find_by_xpedia_slug(params[:name]) || ::Juicer.person_by_name(params[:name])
  end

  def update
    @entity = Entity.find_by_xpedia_slug(params[:name]) || ::Juicer.person_by_name(params[:name])
    @entity.twitter_handle = params[:person][:twitter_handle]
    @entity.xpedia_slug = @entity.url_key
    if @entity.save
      return redirect_to show_profile_path(@entity.url_key), :flash => {'success' => 'Twitter handle successfully saved.' }
    else
      render :edit
    end
  end

  def show
    @articles = ::Juicer.articles_related_to(@person)
    @people   = ::Juicer.people_related_to(@person)
    @organisations = ::Juicer.organisations_related_to(@person) || []

    @tv_programmes = ::Programmes.find_programmes(@person, :tv)
    @radio_programmes = ::Programmes.find_programmes(@person, :radio)

    @upcoming_tv_programmes = ::Programmes.fetch_upcoming_programmes(@person, :tv)
    @upcoming_radio_programmes = ::Programmes.fetch_upcoming_programmes(@person, :radio)

    artist_pid = ::MusicBrainz.fetch_guid(@person.url_key)
    @artist_programmes = ::Programmes.fetch_latest_artist_programmes(artist_pid)
    @latest_tracks = ::Programmes.fetch_latest_artist_tracks(artist_pid)
    @reviews = ::Programmes.fetch_artist_reviews(artist_pid)

    # checks if they're a politician
    @politician = Politician.find_by_xpedia_slug( @person.xpedia_slug)

  end

  def read
    @articles = ::Juicer.articles_related_to(@person)

    respond_to do |format|
      format.html { render 'read' }
      format.rss { render 'profiles/read_rss', :layout => false }
    end
  end

  def listen
    @programme_type = 'radio'
    @programmes = ::Programmes.find_radio_programmes_by_person(@person)

    respond_to do |format|
      format.html { render 'programme' }
      format.rss { render 'profiles/programme_rss', :layout => false }
    end
  end

  def listen_all
    @programme_type = 'radio'
    @programmes = ::Programmes.find_radio_programmes_by_person(@person)
    @upcoming_programmes = ::Programmes.fetch_upcoming_programmes(@person, :radio)

    render 'all_programmes'
  end


  def watch_all
    @programme_type = 'tv'
    @programmes = ::Programmes.find_programmes(@person, :tv)
    @upcoming_programmes = ::Programmes.fetch_upcoming_programmes(@person, :tv)

    render 'all_programmes'
  end

  def watch
    @programme_type = 'tv'
    @programmes = ::Programmes.find_programmes(@person, :tv)

    respond_to do |format|
      format.html { render 'programme' }
      format.rss { render 'profiles/programme_rss', :layout => false }
    end
  end

  def radio_schedules
    @programme_type = 'radio'
    @programmes = ::Programmes.fetch_upcoming_programmes(@person, :radio)
    calendar = Programme.calendar(@programmes)

     respond_to do |format|
       format.ics do
         headers['Content-Type'] = "text/calendar; charset=UTF-8"
         render :text => calendar.to_ical, :layout => false
       end
       format.html { render 'programme' }
     end
  end

  def tv_schedules
    @programme_type = 'tv'
    @programmes = ::Programmes.fetch_upcoming_programmes(@person, :tv)
    calendar = Programme.calendar(@programmes)

     respond_to do |format|
       format.ics do
         headers['Content-Type'] = "text/calendar; charset=UTF-8"
         render :text => calendar.to_ical, :layout => false
       end
       format.html { render 'upcoming_programmes' }
     end
  end

  def follow
    return unless current_user
    unless current_user.is_following?(@person)
      Following.create!(user_id: current_user.id, dbpedia_key: @person.url_key)
    end
    render :text => 'set following'
  end

  def unfollow
    return unless current_user
    if current_user.is_following?(@person)
      following = Following.where(user_id: current_user.id, dbpedia_key: @person.url_key).first
      following.destroy
    end
    render :text => 'set follow'
  end

  private
  def set_person
    unless params[:name].blank?
      @person = Entity.find_by_xpedia_slug(params[:name])
      unless @person
        @name = CGI::unescape(params[:name])
        @person = ::Juicer.person_by_name(@name) || not_found
      end
    end
  end

end
