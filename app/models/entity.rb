require 'open-uri'

class Entity < ActiveRecord::Base

  attr_accessible :name, :description, :dbpedia_uri, :cooccurence_count, :image_uri, :xpedia_slug

  validates :name, :presence => true

  def url_key
    URI.escape(CGI.escape( self.dbpedia_uri.split( '/' ).last ),'.')
  end

  def image
    self.image_uri || 'silhouette.png'
  end
end
