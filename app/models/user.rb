require 'em-http'
require 'em-http/middleware/oauth'
require 'em-http/middleware/json_response'

class User < ActiveRecord::Base

  has_many :friends
  has_many :followings

  def import_twitter_friends

    oAuthConfig = {
      :consumer_key    => ENV['TWITTER_CONSUMER_KEY'],
      :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'],
      :token           => token,
      :token_secret    => secret
    }

    EM.run do
      # automatically parse the JSON response into a Ruby object
      EventMachine::HttpRequest.use EventMachine::Middleware::JSONResponse

      # sign the request with OAuth credentials
      conn = EventMachine::HttpRequest.new('https://userstream.twitter.com/1.1/user.json')
      conn.use EventMachine::Middleware::OAuth, oAuthConfig

      http = conn.get
      http.callback do
        http.response['friends'].each do |friend|
          self.add_friend Friend.create(twitter_id: friend)
          self.follow Entity.find_by_twitter_id(friend)
        end
        self.save
        EM.stop
      end

      http.errback do
        #puts "Failed retrieving user stream."
        EM.stop
      end
    end
  end

  handle_asynchronously :import_twitter_friends

  def to_param
    twitter_handle
  end

  def is_following?(entity)
    !!self.followings.where(dbpedia_key: entity.url_key).first
  end

  def followings_as_entities
    self.followings.map do |following|
      Entity.fetch_by_dbpedia_key(following.dbpedia_key)
    end.compact
  end

  def admin?
    self.role == 'admin'
  end

  def xpedia_slug
    xpedia_slug || url_key
  end

  def follow(entity)
    if entity.present?
      self.followings << Following.create(user_id: self.id, dbpedia_key: entity.url_key)
    end
  end

  def has_friend?(friend)
    self.friends.where(twitter_id: friend.twitter_id).present?
  end

  def add_friend(friend)
    self.friends << friend unless has_friend?(friend)
  end

end
