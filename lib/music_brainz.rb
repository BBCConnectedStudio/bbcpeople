require 'cgi'

class MusicBrainz
  include HTTParty
  #http_proxy 'www-cache.reith.bbc.co.uk', 80 if Rails.env.development?

  class << self

    def fetch_guid(resource_name)
      # get the guid for a resource
      response = get("http://musicbrainz.org/ws/2/url?resource=http://en.wikipedia.org/wiki/#{CGI::escape(resource_name)}&fmt=json&inc=artist-rels")

      return nil unless response.code == 200
      json_data = JSON.parse(response.body)

      json_data['relations'][0]['artist']['id']
    end
  end
end
