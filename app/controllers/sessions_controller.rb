class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid'])
    unless user
      user = User.new
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.twitter_handle = auth['info']['nickname']
      user.token = auth['credentials']['token']
      user.secret = auth['credentials']['secret']
      user.save!

      user.import_twitter_friends
    end
    session['uid'] = user.uid
    session['twitter'] = user.twitter_handle
    flash[:notice] = "Authentication successful."
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
