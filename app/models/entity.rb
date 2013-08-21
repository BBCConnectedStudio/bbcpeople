require 'open-uri'

class Entity < ActiveRecord::Base

  attr_accessible :name, :description, :dbpedia_uri, :cooccurence_count, :image_uri, :xpedia_slug, :twitter_handle

  validates :name, :presence => true

  def url_key
    URI.escape(CGI.escape( self.dbpedia_uri.split( '/' ).last ),'.')
  end

  def image
    self.image_uri || 'silhouette.png'
  end

  def self.fetch_by_dbpedia_key(key)
    person = Entity.find_by_xpedia_slug(key)
    unless person
      name = CGI::unescape(key)
      person = ::Juicer.person_by_name(name)
    end
    person
  end
end
