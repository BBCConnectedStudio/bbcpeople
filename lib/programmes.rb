require 'cgi'

class Programmes
  include HTTParty
  #http_proxy 'www-cache.reith.bbc.co.uk', 80 if Rails.env.development?

  class << self

    # Returns a list of radio programmes relating to an entity or an array of entities
    def find_programmes(entities, type)
      programmes = []
      if entities.is_a? Entity
        programmes = fetch_programmes_for(entities, type)
      else
        entities.each do |entity|
          programmes = programmes | (fetch_programmes_for(entity, type) || Array.new)
        end
      end
      programmes
    end

    # Returns a list of programmes relating to an entity or an array of entities. The second param defines the programme type (radio|tv)
    def fetch_programmes_for(entity, type)
      response = get("http://www.bbc.co.uk/#{type.to_s}/programmes/topics/#{CGI::escape(entity.url_key)}.json")
      return nil unless response.code == 200
      json_data = JSON.parse(response.body)

      json_data['category_page']['available_programmes'].map do |json|
        Programme.new(
          pid:    json['pid'],
          title:  json['display_titles']['title'],
          subtitle: json['display_titles']['subtitle'],
          synopsis: json['short_synopsis'],
          type: type
        )
      end
    end

    def fetch_upcoming_programmes(person, type)
      response = get("http://www.bbc.co.uk/#{type}/programmes/topics/#{CGI::escape(person.url_key)}/schedules/upcoming.json")
      return nil unless response.code == 200
      json_data = JSON.parse(response.body)

      json_data['broadcasts'].map do |json|
        Programme.new(
          pid:    json['programme']['pid'],
          title:  json['programme']['display_titles']['title'],
          subtitle: json['programme']['display_titles']['subtitle'],
          synopsis: json['programme']['short_synopsis'],
          start_time: json['start'].to_datetime,
          end_time: json['end'].to_datetime,
          type: type,
          channel: json['service']['title'],
          image: "http://ichef.bbci.co.uk/images/ic/256x144/legacy/episode/#{json['programme']['pid']}.jpg?nodefault=true"
        )
      end
    end

    def fetch_latest_artist_tracks(guid)
      response = get("http://www.bbc.co.uk/programmes/music/artists/#{guid}.json")
      return nil unless response.code == 200
      json_data = JSON.parse(response.body)

      json_data['artist']['latest_segment_events'].map do |json|
        Programme.new(
          pid:    json['episode']['pid'],
          title:  json['segment']['track_title'],
          subtitle: "#{json['tleo']['title']} #{json['episode']['title']}",
          image: "http://ichef.bbci.co.uk/images/ic/256x144/legacy/episode/#{json['episode']['pid']}.jpg?nodefault=true"
        )
      end
    end

    def fetch_latest_artist_programmes(guid)
      response = get("http://www.bbc.co.uk/programmes/music/artists/#{guid}.json")
      return nil unless response.code == 200
      json_data = JSON.parse(response.body)

      json_data['artist']['tleos_played_on'].map do |json|
        Programme.new(
          pid:    json['pid'],
          title:  json['title'],
          synopsis: json['short_synopsis'],
          image: "http://ichef.bbci.co.uk/images/ic/256x144/legacy/episode/#{json['pid']}.jpg?nodefault=true"
        )
      end
    end

    def fetch_artist_reviews(guid)
      response = get("http://www.bbc.co.uk/music/artists/#{guid}.json")
      return nil unless response.code == 200
      json_data = JSON.parse(response.body)

      json_data['artist']['reviews'].map do |json|
        Review.new(
          url_key:    json['url_key'],
          reviewer:  json['reviewer'],
          short_synopsis: json['short_synopsis'],
          review_date: json['review_date'],
          release_gid: json['release']['gid'],
          release_title: json['release']['title']
        )
      end
    end

  end

end
