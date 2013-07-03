class Programmes
  include HTTParty
  #http_proxy 'www-cache.reith.bbc.co.uk', 80 if Rails.env.development?

  class << self

    # Takes a person and returns a list of radio programmes relating to that person
    def find_radio_programmes_by_person(person)
      response = get("http://www.bbc.co.uk/programmes/topics/#{person.name.gsub(' ', '_')}.json")
      json_data = JSON.parse(response.body)

      p = json_data['category_page']['available_programmes'].take(30).map do |json|
        programme = Programme.new(
          pid:    json['pid'],
          title:  json['display_titles']['title'],
          subtitle:  json['display_titles']['subtitle'],
          synopsis:       json['short_synopsis']
        )

        return nil unless json['media_type'] == 'audio'
        programme

      end
      p.compact!
      p
    end

    # Takes a person and returns a list of tv programmes relating to that person
    def find_tv_programmes_by_person(person)
      response = get("http://www.bbc.co.uk/programmes/topics/#{person.name.gsub(' ', '_')}.json")
      json_data = JSON.parse(response.body)

      p = json_data['category_page']['available_programmes'].take(30).map do |json|
        programme = Programme.new(
          pid:    json['pid'],
          title:  json['display_titles']['title'],
          subtitle:  json['display_titles']['subtitle'],
          synopsis:       json['short_synopsis']
        )

        return nil if json['media_type'] == 'audio'
        programme

      end
      p.compact!
      p
    end
  end

end
