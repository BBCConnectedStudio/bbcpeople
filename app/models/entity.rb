require 'open-uri'

class Entity < ActiveRecord::Base

  attr_accessible :name, :description, :dbpedia_uri, :cooccurence_count, :image_uri, :xpedia_slug

  def url_key
    URI.escape(CGI.escape( self.dbpedia_uri.split( '/' ).last ),'.')
  end
end
