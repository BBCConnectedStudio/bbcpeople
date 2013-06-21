class Politician < Entity

  def twitter_uri
    "http://twitter.com/#{self.twitter_handle}" if self.twitter_handle
  end

  def wikipedia_uri
    "http://en.wikipedia.org/wiki/#{self.xpedia_slug}" if self.xpedia_slug
  end
end
