class ProfilesController < ApplicationController

  before_filter :set_person, :except => [:index]

  def index
   @people = ::Juicer.trending_people
   @max_score = @people.first.cooccurence_count
   @page_title = 'People'
  end

  def show
    @articles = ::Juicer.articles_related_to(@person)
    @people   = ::Juicer.people_related_to(@person)
    @organisations = ::Juicer.organisations_related_to(@person)

    @tv_programmes = ::Programmes.find_tv_programmes_by_person(@person)
    @radio_programmes = ::Programmes.find_radio_programmes_by_person(@person)

    @upcoming_tv_programmes = ::Programmes.fetch_upcoming_programmes(@person, :tv)
    @upcoming_radio_programmes = ::Programmes.fetch_upcoming_programmes(@person, :radio)

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

  def watch
    @programme_type = 'tv'
    @programmes = ::Programmes.find_tv_programmes_by_person(@person)

    respond_to do |format|
      format.html { render 'programme' }
      format.rss { render 'profiles/programme_rss', :layout => false }
    end
  end


  private
  def set_person
    unless params[:name].blank?
      @name = CGI::unescape(params[:name])
      @person = ::Juicer.person_by_name(@name) || not_found
    end
  end
end
