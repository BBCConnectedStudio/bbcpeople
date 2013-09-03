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
    unless person && person.name.present?
      name = CGI::unescape(key)
      entity = ::Juicer.person_by_name(name)
      # check if we are dealing with an mp - which has some data, but not all. If so, import their data from dbpedia and save it
      if person.present?
        person.name = entity.name
        person.description = entity.description
        person.dbpedia_uri = entity.dbpedia_uri
        person.image_uri = entity.image_uri
        person.type = 'Person'
        person.save
      end
    end
    person
  end
end
