require 'cgi'

class Nitro
  include HTTParty

  class << self
    def find_contributors(pid)
      params = { programme: pid }
      response = get(api_endpoint_for('people', params))
      return nil unless response.code == 200
      begin
        xml_doc = Nokogiri::XML(response.body)
        nodes = xml_doc.css('contributor ids id[authority=WIKIPEDIA]')
        entities = []
        contributors = []
        if nodes
          nodes.each do |node|
            key = node.text[29..-1]
            name = key.gsub('_', ' ')
            entity = ::Juicer.person_by_name(key)
            if entity
              entities << entity
            else
              contributors << { name: name, key: key }
            end
          end
          [entities, contributors]
        end
      rescue
        nil
      end
    end

    def find_contribs(entities, type, availability_type=:episode)
      programmes = []
      if entities.is_a? Entity
        programmes = fetch_contrib_programmes_for(entities, type, availability_type)
      else
        entities.each do |entity|
          programmes = programmes | (fetch_contrib_programmes_for(entity, type, availability_type) || Array.new)
          programmes.sort! { |x, y| x.start_time <=> y.start_time }.reverse!
        end
      end
      programmes
    end

    def find_upcoming_programmes_contrib(entities, type)
      programmes = []
      if entities.is_a? Entity
        programmes = fetch_upcoming_contrib_programmes_for(entities, type)
      else
        entities.each do |entity|
          programmes = programmes | (fetch_upcoming_contrib_programmes_for(entity, type) || Array.new)
          programmes.sort! { |x, y| x.start_time <=> y.start_time }.reverse!
        end
      end
      programmes
    end


    # Returns a list of programmes relating to an entity or an array of entities. The second param defines the programme type (radio|tv)
    def fetch_contrib_programmes_for(entity, type, availability_type=:episode)
      programmes = []
      pids = []
      contrib_pid = fetch_contributor_pid_for(entity.url_key)
      return nil unless contrib_pid
      params = {
        people: contrib_pid,
        availability_entity_type: availability_type,
        availability: 'available'
      }
      params['media_type'] = type == :radio ? 'audio' : 'audio_video' ;
      url = remove_brackets api_endpoint_for('programmes', params)
      response = get(url)
      return nil unless response.code == 200
      begin
        xml_doc = Nokogiri::XML(response.body)
        if availability_type == 'clip'
      #    debugger
        end
        pids = extract_pids(xml_doc)
      rescue
        nil
      end

      pids.each do |pid|
        programmes << ::Programmes.fetch_programme(pid)
      end
      programmes.compact
    end

    def extract_pids(xml_doc)
      begin
        xml_doc.css('episode > pid').map{|node| node.text}
      rescue
        nil
      end
    end

    # Returns a list of programmes relating to an entity or an array of entities. The second param defines the programme type (radio|tv)
    def fetch_upcoming_contrib_programmes_for(entity, type)
      programmes = []
      pids = []
      contrib_pid = fetch_contributor_pid_for(entity.url_key)
      return nil unless contrib_pid
      params = {
        people: contrib_pid,
        sid: sids_for(type),
        start_time: Time.zone.now.utc.iso8601
      }
      params['media_type'] = type == :radio ? 'audio' : 'audio_video' ;
      url = remove_brackets api_endpoint_for('broadcasts', params)
      response = get(url)
      return nil unless response.code == 200
      begin
        xml_doc = Nokogiri::XML(response.body)
        pids = extract_pids(xml_doc)
      rescue
        nil
      end

      pids.each do |pid|
        programmes << ::Programmes.fetch_upcoming_programme(pid)
      end
      programmes.compact
    end

    def environment
      Rails.configuration.nitro_environment
    end

    def api_key
      return ENV['NITRO_STAGE_API_KEY'] if self.environment == 'stage'
      ENV['NITRO_LIVE_API_KEY']
    end

    def base_url
       environment_path = self.environment == 'stage' ? 'stage/' : ''
      "http://d.bbc.co.uk/#{environment_path}nitro/api/"
    end

    def api_endpoint_for(path, params={}, param_string='')
      api_path = "#{base_url}#{path}"
      params['api_key'] = api_key
      "#{api_path}?#{params.to_query}#{param_string}"
    end

    def fetch_contributor_pid_for(dbpedia_key)
      params = { id: wikipedia_url(dbpedia_key) }
      response = get(api_endpoint_for('people', params))
      return nil unless response.code == 200
      begin
        xml_doc = Nokogiri::XML(response.body)
        xml_doc.css('contributor pid').text
      rescue
        nil
      end
    end

    def wikipedia_url(dbpedia_key)
      "http://en.wikipedia.org/wiki/#{dbpedia_key}"
    end

    def sids_for(type)
      if type == :radio
        service_types = [ 'National Radio', 'Local Radio', 'Regional Radio' ]
      elsif type == :tv
        service_types = [ 'TV' ]
      end
      sids = []
      page_size = 50
      page = 1
      params = { page_size: page_size, page: page }
      params_string = service_types.inject('') { |str, val| str+'&service_type='+CGI::escape(val) }
      response = get(api_endpoint_for('services', params, params_string))
      return nil unless response.code == 200
      begin
        xml_doc = Nokogiri::XML(response.body)
        total_results = xml_doc.css('results').first['total']
        sids |= xml_doc.css('service > sid').map{|node| node.text}
        while total_results.to_i > (page_size * page)
          page += 1
          params = { page_size: page_size, page: page }
          response = get(api_endpoint_for('services', params, params_string))
          return nil unless response.code == 200
          xml_doc = Nokogiri::XML(response.body)
          sids |= xml_doc.css('service > sid').map{|node| node.text}
        end
      rescue
        nil
      end
      sids
    end

    def remove_brackets(url)
      url.gsub('%5B%5D', '')
    end
  end
end
