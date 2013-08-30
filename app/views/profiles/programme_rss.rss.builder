xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @title
    xml.description @description
    xml.link @link

    unless @all_programmes.blank?
      for programme in @all_programmes
        xml.item do
          xml.title "#{programme.title} - #{programme.subtitle}"
          xml.description programme.synopsis
          xml.pubDate programme.start_time.to_s
          xml.link "http://www.bbc.co.uk/programmes/#{programme.pid}"
          xml.guid "http://www.bbc.co.uk/programmes/#{programme.pid}"
        end
      end
    end
  end
end
