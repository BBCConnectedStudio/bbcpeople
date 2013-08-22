class UsersController < ApplicationController

  before_filter :set_user, :except => [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_twitter_handle(params[:id]) || not_found
    @entities = @user.followings_as_entities
    @articles = ::Juicer.articles_related_to(@entities)
    @tv_programmes = ::Programmes.find_programmes(@entities, :tv)
    @radio_programmes = ::Programmes.find_programmes(@entities, :radio)

    @upcoming_radio_programmes = ::Programmes.find_upcoming_programmes(@entities, :radio)
    @upcoming_tv_programmes = ::Programmes.find_upcoming_programmes(@entities, :tv)
  end

  def read
    @articles = ::Juicer.articles_related_to(@user.followings_as_entities)

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

  private
  def set_user
    unless params[:id].blank?
      @user = User.find_by_twitter_handle(params[:id]) || not_found
    end
  end
end
