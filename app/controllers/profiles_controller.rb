class ProfilesController < ApplicationController
  def index
    @page_title = 'People'
  end

  def show
    @person   = ::Juicer.person_by_name(params[:name])

    render :template => 'person/none' unless @person

    @articles = ::Juicer.articles_related_to(@person)
    @people   = ::Juicer.people_related_to(@person)
    @organisations = ::Juicer.organisations_related_to(@person)

    @tv_programmes = ::Programmes.find_tv_programmes_by_person(@person)
    @radio_programmes = ::Programmes.find_radio_programmes_by_person(@person)

    # checks if they're a politician
    @politician = Politician.find_by_xpedia_slug( @person.xpedia_slug)

  end

  def read_rss
    @person   = ::Juicer.person_by_name(params[:name])
    @articles = ::Juicer.articles_related_to(@person)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
