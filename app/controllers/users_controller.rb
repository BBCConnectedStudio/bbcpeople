class UsersController < ApplicationController
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
end
