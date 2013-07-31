class User < ActiveRecord::Base

  has_many :friends

  def import_twitter_friends
    Twitter.configure do |config|
      config.oauth_token = token
      config.oauth_token_secret = secret
    end
    Twitter.friends(twitter_handle).each do |buddy|
      self.friends << Friend.create(twitter_handle: buddy.screen_name)
      sleep(4)
    end
    self.save!
  end
  handle_asynchronously :import_twitter_friends

  def to_param
    twitter_handle
  end

end
