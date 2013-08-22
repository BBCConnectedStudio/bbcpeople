xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @title
    xml.description @description
    xml.link @link

    unless @articles.blank?
      for article in @articles.take(20)
        xml.item do
          xml.title article.headline
          xml.link article.uri
          xml.pubDate article.published_at.to_s(:rfc822)
          xml.guid article.uri
        end
      end
    end
  end
end
