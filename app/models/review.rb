class Review
  include ActiveAttr::Model

  attribute :url_key
  attribute :reviewer
  attribute :short_synopsis
  attribute :review_date
  attribute :release_gid
  attribute :release_title

  def image
    "http://ichef.bbci.co.uk/music/images/reviews/86x86/#{url_key}.jpg"
  end

end
