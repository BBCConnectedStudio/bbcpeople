class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_twitter_handle(params[:id]) || not_found
    @articles = ::Juicer.articles_related_to(@user.followings_as_entities)
    @radio_programmes = nil
    @upcoming_radio_programmes = nil
    @tv_programmes = nil
    @upcoming_tv_programmes = nil
  end
end
