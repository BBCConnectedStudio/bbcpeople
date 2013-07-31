class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_twitter_handle(params[:id]) || not_found
  end
end
