require "spec_helper"

describe UsersController do

  # /users/:twitter_handle
  describe "GET index" do
    it "works" do
      get :index
      response.should be_success
    end
  end

  # /users/:twitter_handle/read
  describe "GET read" do
    let (:user) { create_user }
    it "works" do
      get :read, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/read.rss
  describe "GET read.rss" do
    let (:user) { create_user }
    it "works" do
      get :read, :id => user.twitter_handle, :format => 'rss'
      response.should be_success
    end
  end

  # /users/:twitter_handle/listen/schedules.ics
  describe "GET radio_schedules" do
    let (:user) { create_user }
    it "works" do
      get :radio_schedules, :id => user.twitter_handle, :format => 'ics'
      response.should be_success
    end
  end

  # /users/:twitter_handle/listen/schedules
  describe "GET radio_schedules" do
    let (:user) { create_user }
    it "works" do
      get :radio_schedules, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/listen/player
  describe "GET listen" do
    let (:user) { create_user }
    it "works" do
      get :listen, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/listen/player.rss
  describe "GET listen.rss" do
    let (:user) { create_user }
    it "works" do
      get :listen, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/listen
  describe "GET listen_all" do
    let (:user) { create_user }
    it "works" do
      get :listen_all, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/watch/schedules.ics
  describe "GET tv_schedules" do
    let (:user) { create_user }
    it "works" do
      get :tv_schedules, :id => user.twitter_handle, :format => 'ics'
      response.should be_success
    end
  end

  # /users/:twitter_handle/watch/schedules
  describe "GET tv_schedules" do
    let (:user) { create_user }
    it "works" do
      get :tv_schedules, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/watch
  describe "GET watch_all" do
    let (:user) { create_user }
    it "works" do
      get :watch_all, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/watch/player
  describe "GET watch" do
    let (:user) { create_user }
    it "works" do
      get :watch, :id => user.twitter_handle
      response.should be_success
    end
  end

  # /users/:twitter_handle/watch/player.rss
  describe "GET watch.rss" do
    let (:user) { create_user }
    it "works" do
      get :watch, :id => user.twitter_handle
      response.should be_success
    end
  end


end

def create_user
  @user = User.new
  @user.twitter_handle = 'test_user'
  @user.save
  @user
end

