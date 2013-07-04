xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "BBC People - #{@programme_type.titleize} Programme Feed for #{@person.name}"
    xml.description "Get all the latest #{@programme_type} programmes about #{@person.name}"
    xml.link show_profile_url(@person.url_key)

    unless @programmes.blank?
      for programme in @programmes
        xml.item do
          xml.title "#{programme.title} - #{programme.subtitle}"
          xml.description programme.synopsis
          xml.pubDate programme.created_at.to_s(:rfc822)
          xml.link "http://www.bbc.co.uk/programmes/#{programme.pid}"
          xml.guid "http://www.bbc.co.uk/programmes/#{programme.pid}"
        end
      end
    end
  end
end
